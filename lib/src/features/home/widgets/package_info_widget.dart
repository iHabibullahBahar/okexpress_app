import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/home/models/booking_model.dart';
import 'package:okexpress/src/features/home/views/package_deatils_screen.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class PackageInfoWidget extends StatelessWidget {
  Data bookingData;
  PackageInfoWidget({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          CustomSnackBarService().showErrorSnackBar(
              message:
                  'Demo service is activated. Please enable the production mode');

          Get.to(
            () => PackageDetailsScreen(
              bookingData: bookingData,
            ),
          );
        },
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
                          "Assigned on: ",
                          style: TextStyle(
                            color: zGraySwatch[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          //dd/MM/yyyy
                          (DateFormat('dd/MM/yyyy')
                              .format(
                                  DateTime.parse(bookingData.assignedDatetime!))
                              .toString()),
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
                        bookingData.service!.type!,
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
                    Container(
                      decoration: BoxDecoration(
                        color: zPrimaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          bookingData.vehicleType!.type!,
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
                          bookingData.isLocationInside == 0
                              ? "Inside GTA"
                              : "Outside GTA",
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
      ),
    );
  }
}
