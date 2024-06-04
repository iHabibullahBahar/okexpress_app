import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:okexpress/global.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/features/splash_screen/view/splash_screen.dart';
import 'package:okexpress/src/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Global());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Position? _currentPosition;
  late Timer _timer;

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
      home: SplashScreen(),
      //home: OnboardingScreen(),
      //home: NavigationBarScreen(),

      ///home: InformationScreen(),
      //home: SignInScreen(),
      onInit: () async {
        bool serviceEnabled;
        LocationPermission permission;
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Location services are disabled. Please enable the services')));
        }
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Location permissions are denied')));
          }
        }
        if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Location permissions are permanently denied, we cannot request permissions.')));
        }
        _initLocationService();
      },

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

  Future<void> _initLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomSnackBarService().showErrorSnackBar(
          message:
              'Location services are disabled. Please enable the services');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomSnackBarService()
            .showErrorSnackBar(message: 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CustomSnackBarService().showErrorSnackBar(
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    ///Start a timer to get the location every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      ///TODO: Send the driver location to the server
      // if (GlobalStorage.instance.isLogged) {
      //   var response = await ApiServices.instance.getResponse(requestBody: {
      //     "driver_id": GlobalStorage.instance.userId,
      //     "lat": _currentPosition!.latitude,
      //     "lng": _currentPosition!.longitude
      //   }, endpoint: zSendDriverLocationEndpoint);
      // }
    });
  }
}
