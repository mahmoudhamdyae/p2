import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/component/error.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';
import 'package:testt/presentation/main/clients/dialogs/ambers_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/choose_price_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/fridges_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/prices_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/terms_dialog_view.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/alert.dart';
import '../../resources/values_manager.dart';

class AddClient extends StatelessWidget {
  AddClient({super.key});

  final ClientsController controller = instance<ClientsController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

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
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: TextFormField(
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "يحب إضافة اسم للعميل";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "اسم العميل",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: TextFormField(
                            controller: phoneController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "يحب إضافة رقم الهاتف";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "رقم الهاتف",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: TextFormField(
                            controller: addressController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "يحب إضافة عنوان العميل";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "عنوان العميل",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownMenu<String>(
                            initialSelection: "فرد",
                            onSelected: (String? value) {
                              if (value == "تاجر") {
                                controller.setStatus("dealer");
                              } else {
                                controller.setStatus("person");
                              }
                            },
                            dropdownMenuEntries: ["فرد", "تاجر"].map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(value: value, label: value);
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showFridgesDialog(context);
                                },
                                child: const Text("اختر ثلاجة")),
                            Expanded(child: Container()),
                            Text(controller.fridge.value.name, style: const TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (controller.fridge.value.name == "") {
                                    showError(context, "اختر ثلاجة أولا");
                                  } else {
                                    showAmbersDialog(context);
                                  }
                                },
                                child: const Text("اختر عنبر")),
                            Expanded(child: Container()),
                            Text(controller.amber.value.name, style: const TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showTermsDialog(context);
                                },
                                child: const Text("اختر فترة")),
                            Expanded(child: Container()),
                            Text(controller.term.value.name, style: const TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showPricesDialog(context);
                                },
                                child: const Text("اختر النوع من قائمة الأسعار")),
                            Expanded(child: Container()),
                            Text(controller.price.value.vegetableName, style: const TextStyle(fontSize: 16))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showChoosePriceDialogDialog(context);
                        }, child: const Text("حساب السعر")
                    ),
                    Expanded(child: Container()),
                    Text(
                        controller.wayNumber.value == 1 ? "الطريقة الأولى" : (controller.wayNumber.value == 2 ? "الطريقة الثانية" : (controller.wayNumber.value == 3 ? "الطريقة الثالثة" : "")),
                        style: const TextStyle(fontSize: 16)
                    )

                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        var formData = formState.currentState;
                        if (formData!.validate()) {
                          formData.save();

                          if (controller.fridge.value.name == "") {
                            showError(context, "يجب إضافة ثلاجة");
                          } else if (controller.amber.value.name == "") {
                            showError(context, "يجب إضافة عنبر");
                          } else if (controller.term.value.name == "") {
                            showError(context, "يجب إضافة فترة");
                          } else if (controller.price.value.vegetableName == "") {
                            showError(context, "يجب إضافة نوع");
                          } else if (controller.wayNumber.value == 0) {
                            showError(context, "يجب إضافة طريقة تحديد السعر");
                          } else {
                            showLoading(context);
                            try {
                              controller.addClient(nameController.text, phoneController.
                              text, addressController.text).then((value) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          } on Exception {
                            Navigator.of(context).pop();
                          }
                          }
                        }
                      },
                      child: const Text("إضافة عميل"))
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
