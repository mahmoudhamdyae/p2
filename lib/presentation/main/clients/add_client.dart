import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
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
      body: Column(
        children: [
          GestureDetector(
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
          GestureDetector(
            onTap: () {
              showAmbersDialog(context);
            },
            child: Row(
              children: [
                Text("اختر عنبر"),
                Expanded(child: Container()),
                Text(controller.fridge.value.name)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showTermsDialog(context);
            },
            child: Row(
              children: [
                Text("اختر فترة"),
                Expanded(child: Container()),
                Text(controller.fridge.value.name)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showPricesDialog(context);
            },
            child: Row(
              children: [
                Text("اختر سعر"),
                Expanded(child: Container()),
                Text(controller.fridge.value.name)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
