import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/contollers/local_storage_controller.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/logs/models/log_model.dart';
import 'package:okexpress/src/features/logs/models/tag_level_model.dart';
import 'package:okexpress/src/helper/api_services.dart';
import 'package:okexpress/src/utils/api_urls.dart';
import 'package:okexpress/src/utils/app_constants.dart';

class LogController extends GetxController {
  static LogController get instance => Get.find();
  RxBool isLogFetching = false.obs;
  RxBool isLogCreating = false.obs;
  TextEditingController messageController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  var selectedTagLevel = TagLevelModel(name: 'Booking', value: 'booking');
  @override
  void onInit() {
    retriveLogData();
  }

  LogModel logModel = LogModel();
  retriveLogData() async {
    try {
      int userId = await LocalStorageController.instance.getInt(zUserId);
      var requestBody = {
        "driver_id": userId,
      };
      isLogFetching.value = true;
      var response = await ApiServices.instance
          .getResponse(requestBody: requestBody, endpoint: zShowLogsEndpoint);
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        logModel = LogModel.fromJson(decoded);
        isLogFetching.value = false;
      } else {
        CustomSnackBarService()
            .showErrorSnackBar(message: "Something went wrong");
      }
    } catch (e) {
      print('Error retriving Logs data: $e');
    }
    isLogFetching.value = false;
  }

  createLog() async {
    try {
      int userId = await LocalStorageController.instance.getInt(zUserId);
      var requestBody = {
        "driver_id": userId,
        "message": messageController.text,
        "referenceNo": referenceController.text,
        "logLevel": selectedTagLevel.value,
      };
      isLogCreating.value = true;
      var response = await ApiServices.instance
          .getResponse(requestBody: requestBody, endpoint: zCreateLogEndpoint);
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isLogCreating.value = false;
        retriveLogData();
        messageController.clear();
        referenceController.clear();
        selectedTagLevel = TagLevelModel(name: 'Booking', value: 'booking');
        CustomSnackBarService().showSuccessSnackBar(message: "Log created");
      } else {
        CustomSnackBarService()
            .showErrorSnackBar(message: "Something went wrong");
      }
    } catch (e) {
      print('Error creating Logs data: $e');
    }
    isLogCreating.value = false;
  }

  //booking, urgent, silent, transaction, others
  List<TagLevelModel> tagLevelList = [
    TagLevelModel(name: 'Booking', value: 'booking'),
    TagLevelModel(name: 'Urgent', value: 'urgent'),
    TagLevelModel(name: 'Silent', value: 'silent'),
    TagLevelModel(name: 'Transaction', value: 'transaction'),
    TagLevelModel(name: 'Others', value: 'others'),
  ];
}
