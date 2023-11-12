import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/main/fridges/fridges_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';

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
        title: const Text(AppStrings.edit_fridge),
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
          return Column(
            children: [
              Row(
                children: [
                  Text("اسم الثلاجة: "),
                  Text(controller.fridge.value?.name ?? "")
                ],
              )
            ],
          );
        }
      }),
    );
  }
}