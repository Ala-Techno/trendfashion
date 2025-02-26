import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class navBarControllers extends GetxController {
  var currentIndex = 1.obs;  // Start with Home as default

  void OnTap(int index) {
    currentIndex.value = index;
  }
}