import 'dart:convert';

import 'package:get/get.dart';
import 'package:okexpress/src/common/contollers/local_storage_controller.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/home/models/booking_model.dart';
import 'package:okexpress/src/helper/api_services.dart';
import 'package:okexpress/src/utils/api_urls.dart';
import 'package:okexpress/src/utils/app_constants.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    retriveBookingData();
  }

  BookingModel bookingModel = BookingModel();
  RxBool isHomeLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  int page = 1;
  int totalPages = 1;
  retriveBookingData({bool isRefresh = true}) async {
    if (isRefresh) {
      page = 1;
      isHomeLoading.value = true;
    } else {
      page++;
      if (page > totalPages) {
        page--;
        return;
      }
      isMoreLoading.value = true;
    }
    try {
      int userId = await LocalStorageController.instance.getInt(zUserId);

      var requestBody = {
        "driver_id": userId,
        "status": selectedIndex.value == 0
            ? "assigned"
            : selectedIndex.value == 1
                ? "picked"
                : "delivered",
        "page": page,
      };
      var response = await ApiServices.instance.getResponse(
          requestBody: requestBody, endpoint: zBookingDriverEndpoint);
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (isRefresh) {
          bookingModel = BookingModel.fromJson(decoded);
        } else {
          isHomeLoading.value = true;
          bookingModel.data!.addAll(BookingModel.fromJson(decoded).data!);
          isMoreLoading.value = false;
        }
        print('Booking data: ${bookingModel.data!.length}');
        totalPages = bookingModel.totalpage!;
        isHomeLoading.value = false;
      } else {
        CustomSnackBarService()
            .showErrorSnackBar(message: "Something went wrong");
      }
    } catch (e) {
      print('Error retriving booking data: $e');
    }
    isHomeLoading.value = false;
  }
}
