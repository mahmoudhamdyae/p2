import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';
import '../clients_controller.dart';

void showPricesDialog(BuildContext context) {
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
    controller.getPrices();
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
            if (controller.prices.value.isEmpty) {
              return emptyScreen(context, "لا يوجد أنواع");
            } else {
              return ListView.builder(
                  itemCount: controller.prices.value.length,
                  itemBuilder: (context, index) {
                    final item = controller.prices.value[index];
                    return GestureDetector(
                      onTap: () {
                        controller.setPrice(item);
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(item.vegetableName),
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
