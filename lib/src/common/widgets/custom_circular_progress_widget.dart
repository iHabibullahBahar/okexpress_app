import 'package:flutter/material.dart';

class CustomCircularProgressWidget extends StatelessWidget {
  const CustomCircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SafeArea(
          minimum: EdgeInsets.only(bottom: 20),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ],
    );
  }
}
