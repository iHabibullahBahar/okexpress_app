import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okexpress/global.dart';
import 'package:okexpress/src/features/navigation_bar_screen/views/navigation_bar_screen.dart';
import 'package:okexpress/src/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Global());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'okexpress',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      //home: NavigationBarScreen(),
      //home: SplashScreen(),
      //home: OnboardingScreen(),
      home: NavigationBarScreen(),

      ///home: InformationScreen(),
      //home: SignInScreen(),
      onInit: () async {},

      /// These delegates make sure that the localization data for the proper language is loaded.
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      //Set the default locale.
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: zAppFontFamily,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: zPrimarySwatch,
        // ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
