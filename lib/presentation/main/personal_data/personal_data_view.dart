import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';
import 'package:testt/presentation/main/personal_data/personal_data_edit_view.dart';
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
            return Column(
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Card(
                    elevation: AppSize.s8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "اسم المستخدم: ",
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
                        ),
                        const SizedBox(
                          height: AppSize.s16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "رقم الهاتف: ",
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
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PersonalDataEditView(userName: controller.personalData.value.name)));
                          },
                          child: const Text("تعديل البيانات")
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        }));
  }
}
