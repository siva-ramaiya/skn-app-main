import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackpageController extends GetxController {
  var selectedStar = (-1).obs; // -1 means no star selected
  var feedbackText = ''.obs;
  var followUp = Rxn<bool>(); // null initially
  late final AnimationController animationController;

  void setStar(int index) {
    selectedStar.value = index;
  }

  void setFeedbackText(String text) {
    feedbackText.value = text;
  }

  void setFollowUp(bool? value) {
    if (value != null) {
      followUp.value = value;
    }
  }

  void sendFeedback() {
    // Example: print feedback or send to API
    print('Stars: $selectedStar');
    print('Feedback: $feedbackText');
    print('Follow up: $followUp');
  }

  void cancel() {
    selectedStar.value = -1;
    feedbackText.value = '';
    followUp.value = null;
    Get.back();
  }
  // Remove AnimationController initialization and disposal from the controller.
  // AnimationController should be managed in the State class of your widget, not in the controller.
  }

