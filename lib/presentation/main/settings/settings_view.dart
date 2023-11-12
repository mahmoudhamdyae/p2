import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings_title),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.fridgesRoute);
              },
              child: const Text(
                "الثلاجات"
              )
          )
        ],
      ),
    );
  }
}
