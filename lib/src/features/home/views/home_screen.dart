import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/widgets/triple_tab_bar.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/features/home/controllers/home_controller.dart';
import 'package:okexpress/src/features/home/widgets/package_info_widget.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
          flexibleSpace: Container(
            height: 150,
            child: SafeArea(
              minimum: const EdgeInsets.only(top: Dimensions.zDefaultPadding),
              child: TripleTabBar(
                title1: "Assigned",
                title2: "Picked",
                title3: "Delivered",
                onTap1: () {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 0;
                  });
                },
                onTap2: () {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 1;
                  });
                },
                onTap3: () {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 2;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      backgroundColor: zBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              for (int i = 0; i < 10; i++) PackageInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
