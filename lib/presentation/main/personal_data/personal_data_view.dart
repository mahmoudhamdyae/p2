import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class PersonalDataView extends StatelessWidget {

  PersonalDataController controller = instance<PersonalDataController>();

  PersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getPersonalData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.personal_data_button),
      ),
      body: Column(
        children: [
          Text("name"),
          Text(controller.personalData.value.name),
          Text("phone"),
          Text(controller.personalData.value.phone),
          Text("active"),
          Text(controller.personalData.value.active.toString())
        ],
      ),
    );
  }
}
