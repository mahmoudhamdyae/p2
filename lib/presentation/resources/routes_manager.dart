import 'package:flutter/material.dart';
import 'package:testt/presentation/main/clients/clients_view.dart';
import 'package:testt/presentation/main/masrofat/masrofat_view.dart';
import 'package:testt/presentation/main/personal_data/personal_data_view.dart';
import 'package:testt/presentation/main/prices/prices_view.dart';
import 'package:testt/presentation/main/reports/reports_view.dart';
import 'package:testt/presentation/main/settings/settings_view.dart';
import 'package:testt/presentation/main/users/user_view.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../auth/login/login_view.dart';
import '../auth/register/register_view.dart';
import '../main/fridges/fridges_view.dart';
import '../main/main_view.dart';
import '../main/personal_data/personal_data_edit_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
  static const String settingsRoute = "/settings";
  static const String fridgesRoute = "/fridges";
  static const String masrofatRoute = "/masrofat";
  static const String addFridgeRoute = "/add_fridge";
  static const String pricesRoute = "/prices";
  static const String clientsRoute = "/clients";
  static const String reportsRoute = "/reports";
  static const String personalDataRoute = "/personal_data";
  static const String usersRoute = "/users";
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
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.fridgesRoute:
        return MaterialPageRoute(builder: (_) => const FridgesView());
      case Routes.masrofatRoute:
        return MaterialPageRoute(builder: (_) => MasrofatView());
      case Routes.pricesRoute:
        return MaterialPageRoute(builder: (_) => const PricesView());
      case Routes.clientsRoute:
        return MaterialPageRoute(builder: (_) => ClientsView());
      case Routes.reportsRoute:
        return MaterialPageRoute(builder: (_) => ReportsView());
      case Routes.personalDataRoute:
        return MaterialPageRoute(builder: (_) => PersonalDataView());
      case Routes.usersRoute:
        return MaterialPageRoute(builder: (_) => const UsersView());
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