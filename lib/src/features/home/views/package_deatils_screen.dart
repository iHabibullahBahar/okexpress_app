import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/common/widgets/custom_button.dart';
import 'package:okexpress/src/features/home/models/booking_model.dart';
import 'package:okexpress/src/helper/api_services.dart';
import 'package:okexpress/src/utils/api_urls.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageDetailsScreen extends StatelessWidget {
  Data bookingData;
  PackageDetailsScreen({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    // var decoded = null;
    // () async {
    //   var requestBody = {"slug": bookingData.slug};
    //   var response = await ApiServices.instance.getResponse(
    //       requestBody: requestBody, endpoint: zBookingDriverEndpoint);
    //   decoded = jsonDecode(response.body);
    //   print("Response: $decoded");
    // };
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        title: Text(
          "Booking Details",
          style: TextStyle(
            color: zTextColor,
          ),
        ),
        iconTheme: const IconThemeData(color: zTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: zGraySwatch[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 18,
                    ),
                    child: Text(
                      "CS: ${bookingData.status}".toUpperCase(),
                      style: TextStyle(
                        color: zGraySwatch[500],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  title: bookingData.status == "assigned"
                      ? "Change to Picked"
                      : "Change to Delivered",
                  height: 50,
                  textStyle: TextStyle(
                    color: zWhiteColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  radius: 10,
                  onPressed: () {
                    CustomSnackBarService().showErrorSnackBar(
                        message:
                            'Driver activity is disabled. Please enable the services');
                    return;
                  },
                ),
              ],
            ),
            Gap(20),
            Container(
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
                          "Slug: ${bookingData.slug}",
                          style: TextStyle(
                            color: zGraySwatch[500],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                color: zGraySwatch[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                  bookingData.assignedDatetime!)),
                              style: TextStyle(
                                color: zGraySwatch[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Container(
                          width: Get.width - 4 * Dimensions.zDefaultPadding,
                          child: Text(
                            "Service name: ${bookingData.service!.type}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: zTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pickup: ",
                          style: TextStyle(
                            color: zTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          width:
                              Get.width - 4 * Dimensions.zDefaultPadding - 125,
                          child: Text(
                            "123, ABC Street, XYZ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: zTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deliver: ",
                          style: TextStyle(
                            color: zBlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          width:
                              Get.width - 4 * Dimensions.zDefaultPadding - 65,
                          child: Text(
                            "123, ABC Street, XYZ City",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: zTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Text(
                          "Vehicle No: ",
                          style: TextStyle(
                            color: zTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "MH 12 1234",
                          style: TextStyle(
                            color: zTextColor,
                            fontWeight: FontWeight.w500,
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
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Truck",
                              style: TextStyle(
                                color: zTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: zPrimaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Text(
                              "Inside GTA",
                              style: TextStyle(
                                color: zTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: zGraySwatch[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Dimensions.zDefaultPadding,
                    ),
                    child: Container(
                      width:
                          (Get.width - 6 * Dimensions.zDefaultPadding - 10) / 2,
                      child: Column(
                        children: [
                          Text(
                            "Estimated price",
                            style: TextStyle(
                              color: zTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "\$ 100",
                            style: TextStyle(
                              color: zPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: zGraySwatch[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Dimensions.zDefaultPadding,
                    ),
                    child: Container(
                      width:
                          (Get.width - 6 * Dimensions.zDefaultPadding - 10) / 2,
                      child: Column(
                        children: [
                          Text(
                            "Final price",
                            style: TextStyle(
                              color: zTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "\$ 100",
                            style: TextStyle(
                              color: zPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Container(
                  width: 160,
                  child: CustomButton(
                    title: "Pickup Direction",
                    textStyle: TextStyle(
                      color: zWhiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    height: 50,
                    radius: 10,
                    onPressed: () async {
                      ///Url launch for pickup direction
                      !await launchUrl(Uri.parse(
                          "https://www.google.com/maps/search/?api=1&query=${37.785834000000},${-122.406417000000}"));
                    },
                  ),
                ),
                Spacer(),
                Container(
                  width: 160,
                  child: CustomButton(
                    title: "Deliver Direction",
                    textStyle: TextStyle(
                      color: zWhiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    height: 50,
                    radius: 10,
                    onPressed: () async {
                      !await launchUrl(Uri.parse(
                          "https://www.google.com/maps/search/?api=1&query=${37.785834000000},${-122.406417000000}"));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
