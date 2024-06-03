import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/global.dart';
import 'package:okexpress/src/common/contollers/local_storage_controller.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/auth/views/sign_in_screen.dart';
import 'package:okexpress/src/helper/api_services.dart';
import 'package:okexpress/src/helper/token_maker.dart';
import 'package:okexpress/src/utils/api_urls.dart';
import 'package:okexpress/src/utils/app_constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  static RxBool isWritingComplete = true.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool isTermsAndConditionsAccepted = false.obs;

  ///Sign Up With Email and Password
  RxBool isSignUpLoading = false.obs;
  // Future<bool> signUpWithEmailAndPassword() async {
  //   try {
  //     var requestBody = {
  //       "firstname": firstNameController.text,
  //       "lastname": lastNameController.text,
  //       "email": emailController.text,
  //       "pass": passwordController.text,
  //     };
  //     isSignUpLoading.value = true;
  //     var response = await ApiServices.instance.getResponse(
  //       requestBody: requestBody,
  //       endpoint: zSignUpEndpoint,
  //     );
  //     var decoded = jsonDecode(response.body);
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       LocalStorageController.instance
  //           .setString(zEmail, decoded['data']['email']);
  //       LocalStorageController.instance.setInt(zUserId, decoded['data']['uid']);
  //
  //       bool isOTPSent =
  //           await sendOTP(decoded['data']['uid'], decoded['data']['email']);
  //       isSignUpLoading.value = false;
  //
  //       ///Set OneSignal user id
  //       ///Here the employee id will saved as Onesignal external user id
  //
  //       if (isOTPSent) {
  //         return true;
  //       }
  //     } else {
  //       if (decoded['success'] == false) {
  //         Get.snackbar(
  //           'Error',
  //           decoded['message'],
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: zErrorSwatch,
  //           colorText: zWhiteColor,
  //           duration: const Duration(seconds: 2),
  //         );
  //       }
  //       isSignUpLoading.value = false;
  //       return false;
  //     }
  //   } catch (e) {
  //     isSignUpLoading.value = false;
  //     return false;
  //   }
  //   isSignUpLoading.value = false;
  //   return false;
  // }

  ///Sign In With Email and Password
  RxBool isSignInLoading = false.obs;
  Future<bool> signInWithEmailAndPassword() async {
    try {
      isSignInLoading.value = true;
      var token = await TokenMaker.instance.secureAPI(emailController.text);
      var certainty = token['certainty'];
      var security = token['security'];
      var requestBody = {
        "email": emailController.text,
        "password": passwordController.text,
        "certainty": certainty,
        "security": security,
      };
      print(isSignInLoading.value);
      ApiServices.instance
          .getResponse(
        requestBody: requestBody,
        endpoint: zSignInEndpoint,
      )
          .then((response) async {
        var decoded = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          await LocalStorageController.instance
              .setString(zAuthToken, decoded['data']['auth_token']);
          await LocalStorageController.instance
              .setString(zAuthTokenValidTill, decoded['data']['validity']);
          LocalStorageController.instance.setBool(zIsLoggedIn, true);
          GlobalStorage.instance.isLogged = true;
          emailController.clear();
          passwordController.clear();
          //await validateUser();
          isSignInLoading.value = false;
          return true;
        } else {
          if (decoded['success'] == false) {
            CustomSnackBarService()
                .showErrorSnackBar(message: "Invalid email or password");
          }
        }
      });
    } catch (e) {
      print('Error signing in with email and password: $e');
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Apple Sign In
  Future<bool> signInWithApple() async {
    ///TODO: Implement Apple Sign In after getting the Apple Developer Account
    return true;
  }

  ///Sign Out
  Future<void> signOut() async {
    try {
      await LocalStorageController.instance.clearInstance(zAuthToken);
      await LocalStorageController.instance.clearInstance(zAuthTokenValidTill);
      await LocalStorageController.instance.clearInstance(zIsLoggedIn);
      await LocalStorageController.instance.clearInstance(zUserId);
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
