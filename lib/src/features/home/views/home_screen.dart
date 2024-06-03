import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/src/features/auth/controllers/auth_controller.dart';
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
      backgroundColor: zBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}
