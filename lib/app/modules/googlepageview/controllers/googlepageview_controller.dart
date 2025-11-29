import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class GooglepageviewController extends GetxController {
  // User location
  final position = Rxn<LatLng>();
  final cameraPosition = Rxn<CameraPosition>();
  StreamSubscription<Position>? positionStream;

  // Delivery simulation
  Rx<LatLng?> deliveryPosition = Rx<LatLng?>(null);
  Rx<Marker?> deliveryMarker = Rx<Marker?>(null);
  BitmapDescriptor? deliveryIcon;
  Timer? _deliveryTimer;

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    _loadDeliveryIcon();
    _initUserTracking();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Load delivery bike icon from assets
  Future<void> _loadDeliveryIcon() async {
    deliveryIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(42, 42)),
      'assets/images/iconsbike.png',
    );
  }

  // Real-time user location tracking
  Future<void> _initUserTracking() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position.value = LatLng(currentPosition.latitude, currentPosition.longitude);

    cameraPosition.value = CameraPosition(
      target: position.value!,
      zoom: 16,
    );

    _startDeliverySimulation();

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((newPosition) {
      position.value = LatLng(newPosition.latitude, newPosition.longitude);

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(newPosition.latitude, newPosition.longitude),
          ),
        );
      }
    });
  }

  // Simulated delivery movement
  void _startDeliverySimulation() {
    if (position.value == null) return;

    LatLng start = LatLng(
      position.value!.latitude + 0.001,
      position.value!.longitude + 0.001,
    );
    deliveryPosition.value = start;

    _deliveryTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final current = deliveryPosition.value;
      if (current == null) return;

      final newPos = LatLng(
        current.latitude - 0.0001,
        current.longitude - 0.0001,
      );
      deliveryPosition.value = newPos;

      deliveryMarker.value = Marker(
        markerId: const MarkerId('delivery_boy'),
        position: newPos,
        icon: deliveryIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Delivery On The Way'),
      );
    });
  }

  @override
  void onClose() {
    positionStream?.cancel();
    _deliveryTimer?.cancel();
    super.onClose();
  }
}
