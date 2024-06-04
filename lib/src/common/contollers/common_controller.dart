import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonController extends GetxController {
  static CommonController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  String utcToLocal(String timeInUtc) {
    String utcTimeString = timeInUtc;
    DateTime utcTime = DateTime.parse(utcTimeString);
    DateTime localTime = utcTime.toLocal();
    String formattedLocalTime =
        DateFormat('yyyy/MM/dd hh:mm a').format(localTime);
    return formattedLocalTime;
  }
}
