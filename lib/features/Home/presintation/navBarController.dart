import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class navBarControllers extends GetxController {
  final RxInt currentIndex = 0.obs; // Make it observable

  void OnTap(int index) {
    currentIndex.value = index;
  }
}
