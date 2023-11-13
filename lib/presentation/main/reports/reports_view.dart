import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.reports_button),
      ),
      body: Placeholder(),
    );
  }
}
