import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/main/fridges/dialogs/edit_amber_dialog.dart';
import 'package:testt/presentation/main/fridges/fridges_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../common/state_renderer/state_renderer.dart';

class ViewFridgeView extends StatelessWidget {
  FridgesController controller = instance<FridgesController>();
  final Fridge fridge;

  ViewFridgeView({super.key, required this.fridge});

  @override
  Widget build(BuildContext context) {
    controller.showFridge(fridge.id);
    controller.showFridge(fridge.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(fridge.name),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return StateRenderer(
              stateRendererType: StateRendererType.fullScreenLoadingState,
              retryActionFunction: () {});
        } else if (controller.error.value != '') {
          return StateRenderer(
              stateRendererType: StateRendererType.fullScreenErrorState,
              message: controller.error.value.replaceFirst(
                  "Exception: ", ""),
              retryActionFunction: () async {
                await controller.getFridges();
              });
        } else {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.fridge_name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppSize.s24
                      ),
                    ),
                    Text(
                      controller.fridge.value.name,
                      style: const TextStyle(
                          fontSize: AppSize.s24
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                Row(
                  children: [
                    Text(
                      AppStrings.ambars_number,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: AppSize.s24
                      ),
                    ),
                    Text(
                      controller.fridge.value.ambers.length.toString(),
                      style: const TextStyle(
                          fontSize: AppSize.s24
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                Row(
                  children: [
                    Text(
                      AppStrings.owner_name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppSize.s24
                      ),
                    ),
                    Text(
                      controller.fridge.value.owner.name,
                      style: const TextStyle(
                          fontSize: AppSize.s24
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                if (controller.fridge.value.ambers.isEmpty) Container() else Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          Text(
                              AppStrings.ambers_name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: AppSize.s20
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.fridge.value.ambers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(AppPadding.p8),
                                    child: Card(
                                      elevation: AppSize.s8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: AppPadding.p8,
                                            bottom : AppPadding.p8,
                                            right: AppPadding.p16,
                                            left: AppPadding.p16
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              controller.fridge.value.ambers[index].name,
                                              style: const TextStyle(
                                                  fontSize: AppSize.s24
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            IconButton(
                                              onPressed: () {
                                                showEditAmberDialog(context, controller.fridge.value.ambers[index], controller.fridge.value.id.toString());
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.black38,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                return AwesomeDialog(
                                                    btnCancelText: "الغاء",
                                                    btnOkText: "حذف",
                                                    context: context,
                                                    dialogType: DialogType.noHeader,
                                                    title: "حذف العنبر",
                                                    desc: "هل أنت متأكد من حذف ${controller.fridge.value.ambers[index].name} ؟",
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () async {
                                                      await controller.delAmber(controller.fridge.value.ambers[index]);
                                                    }).show();
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            ),
          );
        }
      }),
    );
  }
}