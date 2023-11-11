import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
      if (isUserLoggedIn) {
          // Navigate to main screen
          Navigator.pushReplacementNamed(context, Routes.mainRoute)
        }
      else {
          // Navigate to login screen
          Navigator.pushReplacementNamed(context, Routes.loginRoute)
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
      Center(
          child: SizedBox(
          height: AppSize.s300,
          width: AppSize.s300,
          child: Lottie.asset(JsonAssets.splash)
      )
    ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
