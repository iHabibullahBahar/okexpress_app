import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/global.dart';
import 'package:okexpress/src/common/contollers/local_storage_controller.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/auth/views/sign_in_screen.dart';
import 'package:okexpress/src/features/navigation_bar_screen/views/navigation_bar_screen.dart';
import 'package:okexpress/src/features/profile/models/profile_model.dart';
import 'package:okexpress/src/helper/api_services.dart';
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

  ///Sign In With Email and Password
  RxBool isSignInLoading = false.obs;
  ProfileModel profileModel = ProfileModel();
  Future<bool> signInWithEmailAndPassword({bool isFromProfile = false}) async {
    try {
      isSignInLoading.value = true;
      var requestBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var response = await ApiServices.instance
          .getResponse(requestBody: requestBody, endpoint: zSignInEndpoint);
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (!isFromProfile) {
          LocalStorageController.instance.setBool(zIsLoggedIn, true);
          LocalStorageController.instance
              .setString(zEmail, emailController.text);
          LocalStorageController.instance
              .setString(zPassword, passwordController.text);
          GlobalStorage.instance.isLogged = true;
          emailController.clear();
          passwordController.clear();
          isSignInLoading.value = false;
          Get.offAll(() => NavigationBarScreen());
        }
        //await validateUser();
        profileModel = ProfileModel.fromJson(decoded);
        isSignInLoading.value = false;
        return true;
      } else {
        if (!isFromProfile) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Invalid email or password");
        }
      }
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
      await LocalStorageController.instance.clearInstance(zIsLoggedIn);
      await LocalStorageController.instance.clearInstance(zEmail);
      await LocalStorageController.instance.clearInstance(zPassword);
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
