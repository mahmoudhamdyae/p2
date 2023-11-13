import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/reports/reports_controller.dart';

import '../../resources/strings_manager.dart';

class ReportsView extends StatelessWidget {

  final ReportsController controller = instance<ReportsController>();

  ReportsView({super.key});

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
