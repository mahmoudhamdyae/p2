import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';
import '../clients_controller.dart';

void showFridgesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatelessWidget {
  CustomDialog({super.key});

  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    controller.getFridges();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return StateRenderer(
                stateRendererType: StateRendererType.fullScreenLoadingState,
                retryActionFunction: () {});
          } else if (controller.error.value != '') {
            return StateRenderer(
                stateRendererType: StateRendererType.fullScreenErrorState,
                message: controller.error.value.replaceFirst("Exception: ", ""),
                retryActionFunction: () async {
                  await controller.getPrices();
                });
          } else {
            if (controller.fridges.value.isEmpty) {
              return emptyScreen(context, "لا يوجد ثلاجات");
            } else {
              return ListView.builder(
                  itemCount: controller.fridges.value.length,
                  itemBuilder: (context, index) {
                    final item = controller.fridges.value[index];
                    return GestureDetector(
                      onTap: () {
                        controller.setFridge(item);
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(item.name),
                      ),
                    );
                  });
            }
          }
        })
        ,
      ),
    );
  }
}
