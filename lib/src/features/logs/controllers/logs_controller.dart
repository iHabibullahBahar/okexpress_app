import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/features/logs/models/tag_level_model.dart';

class LogController extends GetxController {
  static LogController get instance => Get.find();
  RxBool isLogFetching = false.obs;
  RxBool isLogCreating = false.obs;
  TextEditingController messageController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  var selectedTagLevel = TagLevelModel(name: 'Booking', value: 'booking');
  @override
  void onInit() {}
  fetchLogs() async {
    isLogFetching.value = true;
    try {} catch (e) {
      print(e);
    }
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
