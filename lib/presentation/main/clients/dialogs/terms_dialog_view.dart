import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/presentation/main/clients/dialogs/add_term_dialog.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';
import '../clients_controller.dart';

void showTermsDialog(BuildContext context) {
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
    controller.getTerms();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
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
                    if (controller.terms.value.isEmpty) {
                      return emptyScreen(context, "لا يوجد فترات");
                    } else {
                      return Expanded(
                        child: ListView.separated(
                            itemCount: controller.terms.value.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              final item = controller.terms.value[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.setTerm(item);
                                  Navigator.of(context).pop();
                                },
                                child: ListTile(
                                  title: Text(item.name),
                                  subtitle: Text("بداية الفترة: ${item.start}    نهاية الفترة ${item.end}"),
                                ),
                              );
                            }),
                      );
                    }
                  }
                }),
              ),
              ElevatedButton(onPressed: () { showAddTermDialog(context); }, child: const Text("إضافة فترة جديدة"))
            ],
          ),
        )
        ,
      ),
    );
  }
}
