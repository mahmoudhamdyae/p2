import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/masrofat/masrofat_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import 'dialogs/add_masrouf_dialog.dart';
import 'dialogs/edit_masrof_dialog.dart';

class MasrofatView extends StatelessWidget {
  final MasrofatController controller = instance<MasrofatController>();

  MasrofatView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getMasrofat();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.masrofat),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            showAddMasrofDialog(context);
          }),
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
                await controller.getMasrofat();
              });
        } else {
          if (controller.masrofat.value.isEmpty) {
            return emptyScreen(context, "لا يوجد مصروفات");
          } else {
            return ListView.builder(
              itemCount: controller.masrofat.value.length,
              itemBuilder: (context, index) {
                final item = controller.masrofat.value[index];

                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Card(
                    elevation: AppSize.s8,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.description),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  showEditMasrofDialog(context, item);
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
                                      title: "حذف",
                                      desc: "هل أنت متأكد من حذف ${item.description} ؟",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await controller.delMasrof(item.id);
                                        await controller.getMasrofat();
                                      }).show();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          )
                        ],
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
