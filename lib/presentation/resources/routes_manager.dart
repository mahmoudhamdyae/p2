import 'package:flutter/material.dart';
import 'package:testt/presentation/main/prices/prices_view.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../auth/login/login_view.dart';
import '../auth/register/register_view.dart';
import '../main/fridges/add_fridge/add_fridge_view.dart';
import '../main/fridges/edit_fridge/edit_fridge_view.dart';
import '../main/fridges/fridges_view.dart';
import '../main/main_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
  static const String fridgesRoute = "/fridges";
  static const String addFridgeRoute = "/add_fridge";
  static const String pricesRoute = "/prices";
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.fridgesRoute:
        return MaterialPageRoute(builder: (_) => const FridgesView());
      case Routes.addFridgeRoute:
        return MaterialPageRoute(builder: (_) => const AddFridgeView());
      case Routes.pricesRoute:
        return MaterialPageRoute(builder: (_) => const PricesView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound),
        )
    ));
  }
}