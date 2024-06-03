import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/features/home/controllers/home_controller.dart';
import 'package:okexpress/src/features/home/views/home_screen.dart';
import 'package:okexpress/src/features/logs/controllers/logs_controller.dart';
import 'package:okexpress/src/features/logs/views/logs_screen.dart';
import 'package:okexpress/src/features/profile/views/profile_screen.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';
import 'package:okexpress/src/utils/images.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;
  // List<dynamic> selectedIcons = [zHomeIcon, zLogsIcon, zProfileIcon];
  List<dynamic> selectedIcons = [Icons.home, Icons.message, Icons.person];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController());
    Get.put(LogController());
    Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedIndex,
        children: [HomeScreen(), LogsScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            gradient: zPrimaryGradientLeftToRight,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              selectedIcons.length,
              (index) => InkWell(
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () async {
                  setState(() {
                    if (index == _selectedIndex) return;
                    _selectedIndex = index;
                  });
                  if (_selectedIndex == 0) {
                  } else if (_selectedIndex == 1) {
                  } else if (_selectedIndex == 2) {}
                },
                child: Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        selectedIcons[index],
                        size: 30,
                        color: zWhiteColor,
                      ),
                      const Gap(15),
                      if (_selectedIndex == index)
                        Image.asset(
                          zNavigationHorizontalBar,
                          height: 5,
                        ),
                      if (_selectedIndex != index)
                        const Gap(
                          5,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
