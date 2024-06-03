import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/features/home/controllers/home_controller.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class TripleTabBar extends StatefulWidget {
  String title1;
  String title2;
  String title3;
  Function onTap1;
  Function onTap2;
  Function onTap3;
  TripleTabBar({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  });

  @override
  State<TripleTabBar> createState() => _TripleTabBarState();
}

class _TripleTabBarState extends State<TripleTabBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.zDefaultPadding,
      ),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: zPrimaryColor.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  widget.onTap1();
                },
                child: Container(
                  width: (Get.width - 4 * Dimensions.zDefaultPadding - 24) / 3,
                  decoration: BoxDecoration(
                    color: HomeController.instance.selectedIndex.value == 0
                        ? zWhiteColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.title1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: zBlackColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print(widget.title2);
                  widget.onTap2();
                },
                child: Container(
                  width: (Get.width - 4 * Dimensions.zDefaultPadding - 24) / 3,
                  decoration: BoxDecoration(
                    color: HomeController.instance.selectedIndex.value == 1
                        ? zWhiteColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.title2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: zBlackColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print(widget.title3);
                  widget.onTap3();
                },
                child: Container(
                  width: (Get.width - 4 * Dimensions.zDefaultPadding - 24) / 3,
                  decoration: BoxDecoration(
                    color: HomeController.instance.selectedIndex.value == 2
                        ? zWhiteColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.title3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: zBlackColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
