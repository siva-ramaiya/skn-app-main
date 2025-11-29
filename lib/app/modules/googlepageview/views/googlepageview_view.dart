import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import '../controllers/googlepageview_controller.dart';

class GooglepageviewView extends GetView<GooglepageviewController> {
  GooglepageviewView({super.key});

  GoogleMapController? _mapController;

  Future<void> openMapDirections(
    double destinationLat,
    double destinationLng,
    String title,
  ) async {
    final availableMaps = await map_launcher.MapLauncher.installedMaps;

    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showDirections(
        destination: map_launcher.Coords(destinationLat, destinationLng),
        destinationTitle: title,
      );
    } else {
      throw 'No map applications available!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        final position = controller.position.value;
        final cameraPosition = controller.cameraPosition.value;

        if (position == null || cameraPosition == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: cameraPosition,
              onMapCreated: (mapController) async {
                _mapController = mapController;
                controller.onMapCreated(mapController);
                await _setMapStyle(context, mapController);
              },
              markers: {
                Marker(
                  markerId: const MarkerId('user'),
                  position: LatLng(position.latitude, position.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                  infoWindow: const InfoWindow(title: 'You are here'),
                ),
                if (controller.deliveryMarker.value != null)
                  controller.deliveryMarker.value!,
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),

            // Search box
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(width * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black54 : Colors.black12,
                        blurRadius: width * 0.015,
                        offset: Offset(0, height * 0.002),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: width * 0.052,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search nearby places...',
                            hintStyle: GoogleFonts.poppins(
                              color: isDark ? Colors.white54 : Colors.black45,
                              fontSize: width * 0.032,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: isDark
                            ? const Color.fromARGB(255, 32, 32, 32)
                            : const Color.fromARGB(255, 255, 255, 255),
                        radius: width * 0.045,
                        backgroundImage: AssetImage(
                          "assets/images/googlemapicons.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Places List
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.2,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return _bottomPlacesList(
                  context,
                  scrollController,
                  width,
                  height,
                  isDark,
                  _mapController,
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Future<void> _setMapStyle(
    BuildContext context,
    GoogleMapController mapController,
  ) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final style = await rootBundle.loadString(
      isDark ? 'assets/map_style_dark.json' : 'assets/map_style_light.json',
    );
    mapController.setMapStyle(style);
  }

  Widget _bottomPlacesList(
    BuildContext context,
    ScrollController scrollController,
    double width,
    double height,
    bool isDark,
    GoogleMapController? mapController,
  ) {
    final List<Map<String, dynamic>> nearbyPlaces = [
      {
        'name': 'Nagettukovil Briyani Corner',
        'rating': 4.8,
        'distance': '1.0 km',
        'Time': 'Mrg:11.00 To Nig:10.00',
        'image': 'assets/images/food1.jpg',
        'phone': '+919999111222',
        'location': const LatLng(10.762622, 78.813914),
      },
      {
        'name': 'Sri Saravana Bhavan Veg',
        'rating': 4.3,
        'distance': '0.6 km',
        'Time': 'Mrg:7.00 To Nig:9.00',
        'image': 'assets/images/food2.jpeg',
        'phone': '+919888777666',
        'location': const LatLng(10.763500, 78.815000),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(width * 0.06)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: width * 0.025),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: height * 0.008),
          Container(
            width: width * 0.12,
            height: height * 0.005,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[400],
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
          ),
          SizedBox(height: height * 0.015),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = nearbyPlaces[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.007,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(width * 0.025),
                    child: Image.asset(
                      place['image'],
                      width: width * 0.16,
                      height: width * 0.16,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    place['name'],
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: width * 0.026,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${place['rating']} ⭐ · ${place['distance']} · ${place['Time']}',
                    style: GoogleFonts.poppins(
                      color: isDark
                          ? Colors.grey[400]
                          : const Color.fromARGB(255, 115, 115, 115),
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.029,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.phone,
                          size: width * 0.052,
                          color: isDark ? Colors.amber : Colors.pink,
                        ),
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: 'tel',
                            path: place['phone'],
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Could not launch dialer',
                                  style: GoogleFonts.poppins(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                                backgroundColor: isDark
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                              ),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.directions,
                          size: width * 0.05,
                          color: isDark ? Colors.pink : Colors.amber,
                        ),
                        onPressed: () async {
                          final LatLng loc = place['location'];
                          final availableMaps =
                              await map_launcher.MapLauncher.installedMaps;

                          if (availableMaps.isNotEmpty) {
                            await availableMaps.first.showDirections(
                              destination: map_launcher.Coords(
                                loc.latitude,
                                loc.longitude,
                              ),
                              destinationTitle: place['name'],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    if (mapController != null && place['location'] != null) {
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: place['location'],
                            zoom: 16,
                            tilt: 45,
                            bearing: 0,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
