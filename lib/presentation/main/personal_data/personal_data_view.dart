import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';
import 'package:testt/presentation/resources/routes_manager.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../resources/values_manager.dart';

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
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "name",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: AppSize.s24
                        ),
                      ),
                      Text(
                        controller.personalData.value.name,
                        style: const TextStyle(
                            fontSize: AppSize.s24
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Row(
                    children: [
                      Text(
                          "phone",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: AppSize.s24
                        ),
                      ),
                      Text(
                        controller.personalData.value.phone,
                        style: const TextStyle(
                            fontSize: AppSize.s24
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.editPersonalDataRoute);
                          },
                          child: const Text("تعديل البيانات")
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }));
  }
}
