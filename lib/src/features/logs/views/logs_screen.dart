import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/services/show_popup.dart';
import 'package:okexpress/src/common/widgets/custom_button.dart';
import 'package:okexpress/src/common/widgets/custom_input_field.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/features/logs/controllers/logs_controller.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  AuthController authController = Get.put(AuthController());
  RxBool isSelecting = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      ShowPopup().showBottomPopUp(
                        context: context,
                        height: 450,
                        view: Container(
                          height: 450,
                          decoration: BoxDecoration(
                            color: zWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scaffold(
                              body: Padding(
                                padding: const EdgeInsets.all(
                                  Dimensions.zDefaultPadding,
                                ),
                                child: ListView(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add new log",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(20),
                                    Row(
                                      children: [
                                        Text(
                                          "Message",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(5),
                                    CustomInputField(
                                      controller: LogController
                                          .instance.messageController,
                                      height: 100,
                                      maxLines: 5,
                                      radius: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Reference no",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(5),
                                    CustomInputField(
                                      controller: LogController
                                          .instance.referenceController,
                                      height: 50,
                                      maxLines: 1,
                                      radius: 10,
                                    ),
                                    Gap(5),
                                    Row(
                                      children: [
                                        Text(
                                          "Tag Level",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(5),
                                    Container(
                                      height: 40,
                                      width: Get.width -
                                          2 * Dimensions.zDefaultPadding,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: zGraySwatch[100]!,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Obx(() {
                                        if (isSelecting.value) {
                                          return Container();
                                        } else {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              items: LogController
                                                  .instance.tagLevelList
                                                  .map((e) => DropdownMenuItem(
                                                        value: e.name,
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(e.name)
                                                          ],
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: LogController.instance
                                                  .selectedTagLevel!.name,
                                              onChanged: (value) {
                                                isSelecting.value = true;
                                                for (var i = 0;
                                                    i <
                                                        LogController
                                                            .instance
                                                            .tagLevelList
                                                            .length;
                                                    i++) {
                                                  if (LogController
                                                          .instance
                                                          .tagLevelList[i]
                                                          .name ==
                                                      value) {
                                                    LogController
                                                        .instance
                                                        .selectedTagLevel!
                                                        .name = value!;
                                                  }
                                                }
                                                isSelecting.value = false;
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                height: 55,
                                                width: double.infinity,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                decoration: BoxDecoration(
                                                  color: zBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                    ),
                                    Gap(20),
                                    CustomButton(
                                        title: "Create Log",
                                        radius: 10,
                                        height: 50,
                                        onPressed: () {})
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                      // ShowPopup().showCenterPopUp(
                      //   context: context,
                      //   height: 250,
                      //   view: Container(
                      //     height: 300,
                      //     width: 350,
                      //     decoration: BoxDecoration(
                      //       color: zWhiteColor,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(
                      //           Dimensions.zDefaultPadding),
                      //       child: Column(
                      //         children: [],
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: zPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.add,
                          color: zWhiteColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: zGraySwatch[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "ID: 123456",
                                style: TextStyle(
                                  color: zGraySwatch[500],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "12 Jan 2024",
                                style: TextStyle(
                                  color: zGraySwatch[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Container(
                                width:
                                    Get.width - 4 * Dimensions.zDefaultPadding,
                                child: Text(
                                  "Hello I need to refuel my car. Is is possible to get a the payment receipt?",
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: zTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: zPrimaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "High",
                                    style: TextStyle(
                                      color: zTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "#123456",
                                style: TextStyle(
                                  color: zGraySwatch[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
