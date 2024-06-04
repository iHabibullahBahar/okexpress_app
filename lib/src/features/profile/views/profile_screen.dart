import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/widgets/custom_button.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      Obx(() {
                        if (AuthController.instance.isSignInLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: zPrimaryColor,
                            ),
                          );
                        } else {
                          return Column(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: FancyShimmerImage(
                                          imageUrl: AuthController.instance
                                                  .profileModel.photo ??
                                              '',
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
                                AuthController.instance.profileModel.name ??
                                    "Driver",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(5),
                              Text(
                                AuthController.instance.profileModel.email ??
                                    "Email",
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
                                    AuthController.instance.profileModel.id
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: zTextColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
              Gap(50),
              CustomButton(
                height: 50,
                radius: 10,
                gradient: zPrimaryGradientLeftToRight,
                title: "Make a Call to Support",
                onPressed: () async {
                  ///TODO: Add support number here
                  !await launchUrl(Uri.parse("tel:+1234567890"))
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Could make a call to support!"),
                          ),
                        )
                      : null;
                },
              ),
              Gap(20),
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
