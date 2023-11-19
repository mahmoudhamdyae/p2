import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/masrofat.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "بحث",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1)
                  )
              ),
              onChanged: (String query) {
                controller.search(query);
              },
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
                    message: controller.error.value.replaceFirst(
                        "Exception: ", ""),
                    retryActionFunction: () async {
                      await controller.getMasrofat();
                    });
              } else {
                if (controller.masrofat.value.isEmpty || controller.masrofat.value == List<Masrofat>.empty()) {
                  return emptyScreen(context, "لا يوجد مصروفات");
                } else {
                  return
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: Text(
                                "الإجمالى: ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: Text(
                                controller.sum.toString(),
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p8),
                  child: Center(
                    child: Text(
                    AppStrings.mablagh,
                    style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    ),),
                  ),
                ),
              ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Center(
                                  child: Text(
                                    AppStrings.desc,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Center(
                                  child: Text(
                                    AppStrings.date,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),


                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.masrofat.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Card(
                                  elevation: AppSize.s8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppPadding.p8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(AppPadding.p8),
                                              child: Text(controller.masrofat[index].amount, style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16,
                                              ),),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(AppPadding.p8),
                                              child: Text(controller.masrofat[index].description, style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16,
                                              ),),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(AppPadding.p8),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(controller.masrofat[index].date, style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                  ),),
                                                  IconButton(
                                                    onPressed: () async {
                                                      return AwesomeDialog(
                                                          btnCancelText: "الغاء",
                                                          btnOkText: "حذف",
                                                          context: context,
                                                          dialogType: DialogType.noHeader,
                                                          title: "حذف",
                                                          desc: "هل أنت متأكد من حذف ${controller.masrofat[index].description} ؟",
                                                          btnCancelOnPress: () {},
                                                          btnOkOnPress: () async {
                                                            await controller.delMasrof(controller.masrofat[index].id);
                                                            await controller.getMasrofat();
                                                          }).show();
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.black38,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}

/*class YourDataTableSource extends DataTableSource {
  final BuildContext context;
  final MasrofatController controller;
  final List<Masrofat> data;

  YourDataTableSource({required this.context, required this.data, required this.controller});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final item = data[index];
    return DataRow(
      onLongPress: () {
        showEditMasrofDialog(context, item);
      },
      cells: [
        DataCell(
            Text(
              item.amount,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            )
        ),
        DataCell(
            Text(
              item.description,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            )
        ),
        DataCell(
            Row(
              children: [
                Text(
                  item.date,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
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
                )
              ],
            )
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}*/
