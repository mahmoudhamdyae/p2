import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/fridges/edit_fridge/edit_fridge_view.dart';
import 'package:testt/presentation/main/fridges/fridges_controller.dart';
import 'package:testt/presentation/main/fridges/view_fridge/fridge_view.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import '../../resources/routes_manager.dart';

class FridgesView extends StatefulWidget {
  const FridgesView({Key? key}) : super(key: key);

  @override
  State<FridgesView> createState() => _FridgesViewState();
}

class _FridgesViewState extends State<FridgesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: null, title: const Text(AppStrings.fridges)),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addFridgeRoute);
          }),
      body: PricesList(),
    );
  }
}

class PricesList extends StatelessWidget {
  PricesList({super.key});
  final FridgesController controller = instance<FridgesController>();

  @override
  Widget build(BuildContext context) {
    controller.getFridges();
    return Obx(() {
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
            if (controller.fridges.value.isEmpty) {
        return emptyScreen(context, "لا يوجد ثلاجات");
            } else {
                return ListView.builder(
                  itemCount: controller.fridges.value.length,
                  itemBuilder: (context, index) {
                    final item = controller.fridges.value[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewFridgeView(fridge: item)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: Card(
                          elevation: AppPadding.p8,
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p4),
                            child: ListTile(
                              title: Text(item.name),
                              subtitle: Text("${item.size} عنابر"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        // _addAmber(item.id);
                                      },
                                      child: const Text("Add Amber")),
                                  IconButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              EditFridgeView(fridge: item)));
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      return AwesomeDialog(
                                          btnCancelText: "الغاء",
                                          btnOkText: "حذف",
                                          context: context,
                                          dialogType: DialogType.noHeader,
                                          title: "حذف ثلاجة",
                                          desc: "هل أنت متأكد من حذف هذه الثلاجة ؟",
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async {
                                            await controller.delFridge(item);
                                          }).show();
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
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
    });
  }
}
