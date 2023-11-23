import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../clients_controller.dart';

Future showResubscribeDialog(BuildContext context, String clientId/*, int fridgeId, int priceId, int termId*/) async {
  final ClientsController controller = instance<ClientsController>();
  try {
    showLoading(context);
    // await controller.showFridge(fridgeId).then((value) async {
    //   await controller.showPrice(priceId).then((value) async {
    //     await controller.showTerm(termId.toString()).then((value) {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogAddTerm(clientId);
          // },
          //     );
          //   });
          // });
        });
  } on Exception catch (e) {
    Navigator.of(context).pop();
    showError(context, e.toString());
  }
}

/*class CustomDialog extends StatelessWidget {
  final int fridgeId;
  final String clientId;
  CustomDialog(this.fridgeId, this.clientId, {super.key});

  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "اختر عنبر",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor
                  ),
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
                        message: controller.error.value.replaceFirst("Exception: ", ""),
                        retryActionFunction: () async {
                          await controller.getPrices();
                        });
                  } else {
                    if (controller.fridge.value.ambers.isEmpty) {
                      return emptyScreen(context, "لا يوجد عنابر");
                    } else {
                      return ListView.separated(
                          itemCount: controller.fridge.value.ambers.length,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final item = controller.fridge.value.ambers[index];
                            return GestureDetector(
                              onTap: () {
                                controller.setAmber(item);
                                showChoosePriceDialogDialog(context, clientId);
                              },
                              child: ListTile(
                                title: Text(item.name),
                              ),
                            );
                          });
                    }
                  }
                }),
              ),
              ElevatedButton(onPressed: () { showAddAmberDialog(context, fridgeId); }, child: const Text("إضافة عنبر"))
            ],
          ),
        )
        ,
      ),
    );
  }
}*/

class CustomDialogAddTerm extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ClientsController controller = instance<ClientsController>();
  String clientId;

  CustomDialogAddTerm(this.clientId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "إضافة فترة",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Form(
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
                          return "يحب إضافة اسم للفترة";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "اسم الفترة",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: TextFormField(
                      controller: startController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "يحب إضافة بداية للفترة";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "بداية الفترة",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: TextFormField(
                      controller: endController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "يحب إضافة نهاية للفترة";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "نهاية الفترة",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var formData = formState.currentState;
                if (formData!.validate()) {
                  formData.save();
                  try {
                    showLoading(context);
                    // await controller.addTerm(nameController.text, startController.text, endController.text)
                    //     .then((userCredential) {
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).pop();
                    // });
                    showChoosePriceDialogDialog(context, clientId);
                  } on Exception catch (e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showError(context, e.toString());
                  }
                }
              },
              child: const Text("إضافة الفترة"),
            ),
          ],
        ),
      ),
    );
  }
}

void showChoosePriceDialogDialog(BuildContext context, String clientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog2(clientId);
    },
  );
}

class CustomDialog2 extends StatelessWidget {
  String clientId;
  CustomDialog2(this.clientId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "اختر طريقة حساب السعر",
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor
                ),
              ),
              ElevatedButton(onPressed: () { showFirstWayDialogDialog1(context, clientId); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الأولى"),
              )),
              ElevatedButton(onPressed: () { showSecondWayDialogDialog1(context, clientId); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الثانية"),
              )),
              ElevatedButton(onPressed: () { showThirdWayDialogDialog1(context, clientId); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الثالثة"),
              )),
            ],
          ),
        )
        ,
      ),
    );
  }
}


void showFirstWayDialogDialog1(BuildContext context, String clientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog3(clientId);
    },
  );
}

class CustomDialog3 extends StatelessWidget {
  String clientId;
  CustomDialog3(this.clientId, {super.key});

  final ClientsController controller = instance<ClientsController>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: quantityController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يحب إدخال كمية";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "الكمية",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: priceController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يحب إدخال سعر";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "السعر",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "إالغاء",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var formData = formState.currentState;
                        if (formData!.validate()) {
                          formData.save();
                          controller.setFirstWay(priceController.text, quantityController.text);
                          showLoading(context);
                          try {
                            await controller.resubscribe(clientId).then((value) {
                              Navigator.of(context).pop();
                            });
                          } on Exception catch (e) {
                            Navigator.of(context).pop();
                            showError(context, e.toString());
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSuccessDialog(context);
                          controller.getClients();
                        } else {
                          showError(context, "يجب ادخال خانة واحدة على الأقل");
                        }
                      },
                      child: const Text("تأكيد"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        ,
      ),
    );
  }
}


void showSecondWayDialogDialog1(BuildContext context, String clientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog4(clientId);
    },
  );
}

class CustomDialog4 extends StatelessWidget {
  String clientId;
  CustomDialog4(this.clientId, {super.key});

  final ClientsController controller = instance<ClientsController>();
  TextEditingController tonController = TextEditingController();
  TextEditingController smallShakaraController = TextEditingController();
  TextEditingController bigShakaraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tonController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "عدد الأطنان",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: smallShakaraController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "عدد الشكاير الصغيرة",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bigShakaraController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "عدد الشكاير الكبيرة",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1))),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "إالغاء",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (tonController.text != "" || smallShakaraController.text != "" || bigShakaraController.text != "") {
                          controller.setSecondWay(tonController.text, smallShakaraController.text, bigShakaraController.text);
                          showLoading(context);
                          try {
                            await controller.resubscribe(clientId).then((value) {
                              Navigator.of(context).pop();
                            });
                          } on Exception catch (e) {
                            Navigator.of(context).pop();
                            showError(context, e.toString());
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSuccessDialog(context);
                          controller.getClients();
                        } else {
                          showError(context, "يجب ادخال خانة واحدة على الأقل");
                        }
                      },
                      child: const Text("تأكيد"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        ,
      ),
    );
  }
}


void showThirdWayDialogDialog1(BuildContext context, String clientId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog5(clientId);
    },
  );
}

class CustomDialog5 extends StatelessWidget {
  String clientId;
  CustomDialog5(this.clientId, {super.key});

  final ClientsController controller = instance<ClientsController>();
  TextEditingController averageController = TextEditingController();
  TextEditingController shakayirController = TextEditingController();
  TextEditingController priceOneController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: averageController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يحب إدخال متوسط وزن الشكارة";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "متوسط وزن الشكارة",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: shakayirController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يحب إدخال متوسط عدد الشكاير";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "عدد الشكاير",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: priceOneController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يحب إدخال سعر الشكارة الواحدة";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "سعر الشكارة الواحدة",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "إالغاء",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var formData = formState.currentState;
                        if (formData!.validate()) {
                          formData.save();
                          controller.setThirdWay(averageController.text, shakayirController.text, priceOneController.text);
                          showLoading(context);
                          try {
                            await controller.resubscribe(clientId).then((value) {
                              Navigator.of(context).pop();
                            });
                          } on Exception catch (e) {
                            Navigator.of(context).pop();
                            showError(context, e.toString());
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSuccessDialog(context);
                          controller.getClients();
                        } else {
                          showError(context, "يجب ادخال خانة واحدة على الأقل");
                        }
                      },
                      child: const Text("تأكيد"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        ,
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Success!'),
        content: Text('تم تجديد الاشتراك'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('حسنا'),
          ),
        ],
      );
    },
  );
}

void showAddAmberDialog(BuildContext context, int fridgeId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog6(fridgeId);
    },
  );
}

class CustomDialog6 extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ClientsController controller = instance<ClientsController>();
  final int fridgeId;

  CustomDialog6(this.fridgeId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.add_anbar,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Form(
              key: formState,
              child: TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.amber_name_invalid;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: AppStrings.amber_name_hint,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var formData = formState.currentState;
                if (formData!.validate()) {
                  formData.save();
                  try {
                    showLoading(context);
                    await controller.addAnbar(fridgeId, nameController.text)
                        .then((userCredential) {
                          // controller.resubscribe(clientId);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } on Exception catch (e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showError(context, e.toString());
                  }
                }
              },
              child: const Text("إضافة العنبر"),
            ),
          ],
        ),
      ),
    );
  }
}


