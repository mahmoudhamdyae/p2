import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.personal_data_button),
      ),
      body: Placeholder(),
    );
  }
}
