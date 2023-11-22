import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';
import '../clients_controller.dart';

void showAmbersDialog(BuildContext context) {
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "اختر عنبر",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor
                  ),
                ),
              ),
              Expanded(
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
                    if (controller.fridge.value.ambers.isEmpty) {
                      return emptyScreen(context, "لا يوجد عنابر");
                    } else {
                      return ListView.separated(
                          itemCount: controller.fridge.value.ambers.length,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final item = controller.fridge.value.ambers[index];
                            return GestureDetector(
                              onTap: () {
                                controller.setAmber(item);
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                title: Text(item.name),
                              ),
                            );
                          });
                    }
                  }
                }),
              ),
            ],
          ),
        )
        ,
      ),
    );
  }
}
