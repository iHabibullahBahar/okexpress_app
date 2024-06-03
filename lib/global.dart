import 'package:get/get.dart';
import 'package:okexpress/src/common/contollers/local_storage_controller.dart';
import 'package:okexpress/src/utils/app_constants.dart';

class Global extends GetxService {
  static Global instance = Get.find();
  @override
  void onInit() {
    super.onInit();
    intiGlobal();
  }

  intiGlobal() async {
    Get.put(LocalStorageController());
    Get.put(GlobalStorage());
  }
}

class GlobalStorage extends GetxService {
  static GlobalStorage instance = Get.find();
  late bool isNotFirstTime;
  late bool isLogged;
  @override
  void onInit() {
    super.onInit();
    intiStorage();
  }

  void intiStorage() async {
    isNotFirstTime =
        await LocalStorageController.instance.getBool(zIsFirstTime) ?? true;
    isLogged =
        await LocalStorageController.instance.getBool(zIsLoggedIn) ?? false;
    print(isLogged);
  }
}
