import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/global.dart';
import 'package:okexpress/src/common/widgets/custom_circular_progress_widget.dart';
import 'package:okexpress/src/features/auth/views/sign_in_screen.dart';
import 'package:okexpress/src/features/navigation_bar_screen/views/navigation_bar_screen.dart';
import 'package:okexpress/src/utils/app_constants.dart';
import 'package:okexpress/src/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (GlobalStorage.instance.isLogged == false) {
        Get.offAll(() => SignInScreen());
      } else {
        Get.offAll(() => NavigationBarScreen());
      }
      // GlobalStorage.instance.isNotFirstTime == false
      //     ? Get.offAll(() => OnboardingScreen())
      //     : GlobalStorage.instance.isLogged == false
      //         ? Get.offAll(() => SignInScreen())
      //         : AuthController.instance.validateUser();
      // Get.offAll(() => GlobalStorage.instance.isNotFirstTime == false
      //     ? OnboardingScreen()
      //     : !GlobalStorage.instance.isLogged
      //         ? SignInScreen()
      //         : NavigationBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: zPrimaryGradientTopToBottom,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   zAppLogo,
                //   height: 80,
                //   width: 80,
                // ),
                // const Gap(15),
                const Text(
                  zAppName,
                  style: TextStyle(
                    fontSize: 35,
                    color: zWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              child: CustomCircularProgressWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
