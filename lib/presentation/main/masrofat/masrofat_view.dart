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
            return /*ListView.builder(
              itemCount: controller.masrofat.value.length,
              itemBuilder: (context, index) {
                final item = controller.masrofat.value[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewMasrofView(masrofat: item)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Card(
                      elevation: AppSize.s8,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 23,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s12,
                                ),
                                Text(
                                  item.amount,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
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
                  ),
                );
              },
            )*/
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      rowsPerPage: (controller.masrofat.length < 10) ? controller.masrofat.length : 10,
                      columns: [
                        DataColumn(
                            label: Text(
                              AppStrings.mablagh,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 23,
                              ),
                            )
                        ),
                        DataColumn(
                            label: Text(
                              AppStrings.desc,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 23,
                              ),
                            )
                        ),
                        DataColumn(
                            label: Text(
                              AppStrings.date,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 23,
                              ),
                            )
                        ),
                      ],
                      source: YourDataTableSource(data: controller.masrofat.value, context: context, controller: controller),
                    )
                  ),
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
                  )
                ],
              );
          }
        }
      }),
    );
  }
}

class YourDataTableSource extends DataTableSource {
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













                /*Row(
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

                  ],
                )*/













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
}
