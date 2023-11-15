import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../resources/strings_manager.dart';

class PersonalDataEditView extends StatelessWidget {
  PersonalDataEditView({super.key});

  PersonalDataController controller = instance<PersonalDataController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل البيانات"),
      ),
      body: Obx(() {
      if (controller.isLoading.value) {
        return StateRenderer(
            stateRendererType: StateRendererType.popupLoadingState,
            retryActionFunction: () {});
      } else if (controller.error.value != '') {
        return StateRenderer(
            stateRendererType: StateRendererType.popupErrorState,
            message: controller.error.value.replaceFirst("Exception: ", ""),
            retryActionFunction: () async {
              await controller.getPersonalData();
            });
      } else {
        return Padding(
          padding: EdgeInsets.all(AppPadding.p20),
          child: Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.userNameInvalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: AppStrings.username,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  TextFormField(
                    controller: numberController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val.toString().length == 11 &&
                          val.toString().startsWith("01")) {
                        return null;
                      }
                      return AppStrings.mobileNumberInvalid;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: AppStrings.phone,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  TextFormField(
                    controller: passController,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.passwordError;
                      }
                      return null;
                    },
                    obscureText: controller.obscureText.value,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            controller.toggleObscureText();
                          },
                        ),
                        hintText: AppStrings.password,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  TextFormField(
                    controller: confirmPassController,
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                      if (val != passController.text) {
                        return AppStrings.passwordConfirmInvalid;
                      }
                      return null;
                    },
                    obscureText: controller.obscureText.value,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            controller.toggleObscureText();
                          },
                        ),
                        hintText: AppStrings.passwordConfirm,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.updatePersonalData(nameController.text, numberController.text, passController.text, confirmPassController.text);
                      },
                      child: Text(
                        "تعديل البيانات",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
                ],
              )),
        );
    }
      },
    ));
  }
}
