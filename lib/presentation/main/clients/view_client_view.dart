import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class ViewClientView extends StatelessWidget {

  final ClientsController controller = instance<ClientsController>();

  ViewClientView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getClients();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.clients_button),
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
                await controller.getPrices();
              });
        } else {
          if (controller.clients.value.isEmpty) {
            return emptyScreen(context, "لا يوجد عملاء");
          } else {
            return ListView.builder(
              itemCount: controller.clients.value.length,
              itemBuilder: (context, index) {
                final item = controller.clients.value[index];

                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ViewFridgeView(fridge: item)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Card(
                        elevation: AppPadding.p8,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "اسم العميل: ${item.name}",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 23,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s12,
                                  ),
                                  Text(
                                    "رقم الهاتف: ${item.phone}",
                                    style: const TextStyle(
                                      color: Colors.black38,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          // showEditFridgeDialog(context, item);
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
                                              title: "حذف عميل",
                                              desc: "هل أنت متأكد من حذف هذه العميل ؟",
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                // await controller.delFridge(item);
                                              }).show();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      }),
    );
  }
}
