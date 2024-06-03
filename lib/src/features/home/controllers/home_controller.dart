import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
