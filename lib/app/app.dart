import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/assets_manager.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  // Named Constructor
  MyApp._internal();

  int appState = 0;

  // Singleton or single instance
  static final MyApp _instance = MyApp._internal();

  // Factory
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      builder: (BuildContext context, Widget? child) {
        return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                ImageAssets.backgroundImage, // Replace with your image path
                fit: BoxFit.fill,
              ),
              Directionality(textDirection: TextDirection.rtl, child: child!)
            ]
        );
      },
    );
  }
}
