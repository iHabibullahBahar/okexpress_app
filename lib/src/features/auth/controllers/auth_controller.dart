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
  Future<bool> signInWithEmailAndPassword() async {
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
        LocalStorageController.instance.setBool(zIsLoggedIn, true);
        LocalStorageController.instance.setString(zEmail, emailController.text);
        LocalStorageController.instance
            .setString(zPassword, passwordController.text);
        LocalStorageController.instance.setInt(zUserId, decoded['id']);
        GlobalStorage.instance.isLogged = true;
        GlobalStorage.instance.userId = decoded['id'];
        emailController.clear();
        passwordController.clear();
        isSignInLoading.value = false;
        profileModel = ProfileModel.fromJson(decoded);
        Get.offAll(() => NavigationBarScreen());
        isSignInLoading.value = false;
        return true;
      } else {
        CustomSnackBarService()
            .showErrorSnackBar(message: "Invalid email or password");
      }
    } catch (e) {
      print('Error signing in with email and password: $e');
    }
    isSignInLoading.value = false;
    return false;
  }

  Future<bool> retriveUserData() async {
    try {
      isSignInLoading.value = true;
      var email = await LocalStorageController.instance.getString(zEmail);
      var password = await LocalStorageController.instance.getString(zPassword);
      var requestBody = {
        "email": email,
        "password": password,
      };
      var response = await ApiServices.instance
          .getResponse(requestBody: requestBody, endpoint: zSignInEndpoint);
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        profileModel = ProfileModel.fromJson(decoded);
        isSignInLoading.value = false;
        return true;
      } else {
        CustomSnackBarService()
            .showErrorSnackBar(message: "Something went wrong");
      }
    } catch (e) {
      print('Error signing in with email and password: $e');
    }
    isSignInLoading.value = false;
    return false;
  }

  ///Sign Out
  Future<void> signOut() async {
    try {
      await LocalStorageController.instance.clearInstance(zIsLoggedIn);
      await LocalStorageController.instance.clearInstance(zEmail);
      await LocalStorageController.instance.clearInstance(zPassword);
      await LocalStorageController.instance.clearInstance(zUserId);
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
