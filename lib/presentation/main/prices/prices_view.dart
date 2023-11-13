import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/fridges/dialogs/add_ambar_dialog.dart';
import 'package:testt/presentation/main/prices/prices_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import 'dialogs/add_price_dialog.dart';
import 'dialogs/edit_price_view.dart';

class PricesView extends StatefulWidget {
  const PricesView({Key? key}) : super(key: key);

  @override
  State<PricesView> createState() => _FridgesViewState();
}

class _FridgesViewState extends State<PricesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: null, title: const Text(AppStrings.prices_button)),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            showAddPriceDialog(context);
          }),
      body: PricesList(),
    );
  }
}

class PricesList extends StatelessWidget {
  PricesList({super.key});
  final PricesController controller = instance<PricesController>();

  @override
  Widget build(BuildContext context) {
    controller.getPrices();
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
              await controller.getPrices();
            });
      } else {
        if (controller.prices.value.isEmpty) {
          return emptyScreen(context, "لا يوجد أسعار");
        } else {
          return ListView.builder(
            itemCount: controller.prices.value.length,
            itemBuilder: (context, index) {
              final item = controller.prices.value[index];

              return Padding(
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
                            Row(
                              children: [
                                Text(
                                  AppStrings.prices_vegetable_name,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: AppSize.s24
                                  ),
                                ),
                                Text(
                                  item.vegetableName,
                                  style: const TextStyle(
                                      fontSize: AppSize.s24
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: AppSize.s16,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppStrings.prices_ton,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: AppSize.s24
                                  ),
                                ),
                                Text(
                                  item.ton,
                                  style: const TextStyle(
                                      fontSize: AppSize.s24
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: AppSize.s16,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppStrings.prices_small_shakara,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: AppSize.s24
                                  ),
                                ),
                                Text(
                                  item.small_shakara,
                                  style: const TextStyle(
                                      fontSize: AppSize.s24
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: AppSize.s16,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppStrings.prices_big_shakara,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: AppSize.s24
                                  ),
                                ),
                                Text(
                                  item.big_shakara,
                                  style: const TextStyle(
                                      fontSize: AppSize.s24
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    showEditPriceDialog(context, item);
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
                                        desc: "هل أنت متأكد ؟",
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          await controller.delPrice(item);
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
              );
            },
          );
        }
      }
    });
  }
}
