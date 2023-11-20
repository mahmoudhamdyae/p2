import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/common/state_renderer/state_renderer.dart';
import 'package:testt/presentation/component/error.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';
import 'package:testt/presentation/main/clients/dialogs/ambers_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/fridges_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/prices_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/terms_dialog_view.dart';

class AddClient extends StatelessWidget {
  AddClient({super.key});

  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة عميل"),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showFridgesDialog(context);
                  },
                  child: Row(
                    children: [
                      Text("اختر ثلاجة"),
                      Expanded(child: Container()),
                      Text(controller.fridge.value.name)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (controller.fridge.value.name == "") {
                      showError(context, "اختر ثلاجة أولا");
                      // StateRenderer(
                      //     stateRendererType: StateRendererType.fullScreenErrorState,
                      //     message: "اختر ثلاجة أولا",
                      //     retryActionFunction: () {});
                    } else {
                      showAmbersDialog(context);
                    }
                  },
                  child: Row(
                    children: [
                      Text("اختر عنبر"),
                      Expanded(child: Container()),
                      Text(controller.amber.value.name)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showTermsDialog(context);
                  },
                  child: Row(
                    children: [
                      Text("اختر فترة"),
                      Expanded(child: Container()),
                      Text(controller.term.value.name)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showPricesDialog(context);
                  },
                  child: Row(
                    children: [
                      Text("اختر سعر"),
                      Expanded(child: Container()),
                      Text(controller.price.value.vegetableName)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
