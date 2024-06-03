import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/widgets/custom_button.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());

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
              Container(
                decoration: BoxDecoration(
                  color: zGraySwatch[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: zGraySwatch[100],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FancyShimmerImage(
                                  imageUrl: "",
                                  height: 100,
                                  width: 100,
                                  errorWidget: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: zGraySwatch[500],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Text(
                        "John Doe",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(5),
                      Text(
                        "bahar@example.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: zGraySwatch[500],
                        ),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Driver ID: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: zGraySwatch[500],
                            ),
                          ),
                          Text(
                            "15562435521",
                            style: TextStyle(
                                fontSize: 14,
                                color: zTextColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(50),
              CustomButton(
                height: 50,
                radius: 10,
                gradient: LinearGradient(
                  colors: [zGraySwatch[400]!, zGraySwatch[400]!],
                ),
                title: "Logout",
                onPressed: () {
                  AuthController.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
