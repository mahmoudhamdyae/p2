import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../common/state_renderer/state_renderer.dart';

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
        body: Obx(() {
          if (controller.isLoading.value) {
            return StateRenderer(
                stateRendererType: StateRendererType.fullScreenLoadingState,
                retryActionFunction: () {});
          } else if (controller.error.value != '') {
            return StateRenderer(
                stateRendererType: StateRendererType.fullScreenErrorState,
                message: controller.error.value.replaceFirst("Exception: ", ""),
                retryActionFunction: () async {
                  await controller.getPersonalData();
                });
          } else {
            return Column(
              children: [
                Text("name"),
                Text(controller.personalData.value.name),
                Text("phone"),
                Text(controller.personalData.value.phone),
                Text("active"),
                Text(controller.personalData.value.active.toString()),
                ElevatedButton(onPressed: () {}, child: Text("تعديل البيانات"))
              ],
            );
          }
        }));
  }
}
