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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        HomeController.instance.isHomeLoading.value == false
            ? HomeController.instance.retriveBookingData(isRefresh: false)
            : null;
      }
    });
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
                onTap1: () async {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 0;
                  });
                  await HomeController.instance.retriveBookingData();
                },
                onTap2: () async {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 1;
                  });
                  await HomeController.instance.retriveBookingData();
                },
                onTap3: () async {
                  setState(() {
                    HomeController.instance.selectedIndex.value = 2;
                  });
                  await HomeController.instance.retriveBookingData();
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
            controller: scrollController,
            children: [
              Obx(() {
                if (HomeController.instance.isHomeLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: zPrimaryColor,
                    ),
                  );
                } else if (HomeController.instance.bookingModel.data!.isEmpty) {
                  return Container(
                    height: Get.height * 0.6,
                    child: Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: zTextColor,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      for (int i = 0;
                          i < HomeController.instance.bookingModel.data!.length;
                          i++)
                        PackageInfoWidget(
                          bookingData:
                              HomeController.instance.bookingModel.data![i],
                        ),
                      Obx(() {
                        if (HomeController.instance.isMoreLoading.value) {
                          return Column(
                            children: [
                              const Center(
                                child: CircularProgressIndicator(
                                  color: zPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
