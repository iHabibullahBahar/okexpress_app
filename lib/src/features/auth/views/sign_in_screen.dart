import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/common/widgets/custom_button_with_icon.dart';
import 'package:okexpress/src/common/widgets/custom_input_field.dart';
import 'package:okexpress/src/common/widgets/custom_shimmer_button.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
import 'package:okexpress/src/features/auth/widgets/auth_header_widget.dart';
import 'package:okexpress/src/utils/colors.dart';
import 'package:okexpress/src/utils/dimensions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: zPrimaryColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Gap(50),
              AuthHeaderWidget(
                title: "Welcome Back!",
                description: "Login to your account",
              ),
              Gap(50),
              CustomInputField(
                hintText: "Email",
                controller: authController.emailController,
                icon: Icons.email,
                isIconRequired: true,
                onChanged: (value) {},
              ),
              CustomInputField(
                hintText: "Password",
                controller: authController.passwordController,
                icon: Icons.remove_red_eye,
                isIconRequired: true,
                isSecure: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: Container(
          height: 95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                print(authController.isSignInLoading.value);
                if (authController.isSignInLoading.value) {
                  print("Loading");
                  return CustomShimmerButton();
                } else {
                  print("Not Loading");
                  return CustomButtonWithIcon(
                    title: "Sign In",
                    onPressed: () async {
                      if (authController.emailController.text.isEmpty ||
                          authController.passwordController.text.isEmpty) {
                        CustomSnackBarService().showWarningSnackBar(
                            message: "Please fill all the fields.");
                      } else {
                        if (authController.isSignInLoading.value == false) {
                          await authController.signInWithEmailAndPassword();
                        }
                      }
                    },
                    icon: Icons.arrow_forward_ios,
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
