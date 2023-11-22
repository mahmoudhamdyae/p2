import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/presentation/component/alert.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../component/empty.dart';
import '../../../component/error.dart';
import '../clients_controller.dart';

Future showResubscribeDialog(BuildContext context, int fridgeId) async {
  final ClientsController controller = instance<ClientsController>();
  await controller.showFridge(fridgeId).then((value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(fridgeId);
      },
    );
  });
}

class CustomDialog extends StatelessWidget {
  final int fridgeId;
  CustomDialog(this.fridgeId, {super.key});

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
                                showChoosePriceDialogDialog(context);
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
            ],
          ),
        )
        ,
      ),
    );
  }
}

void showChoosePriceDialogDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CustomDialog2();
    },
  );
}

class CustomDialog2 extends StatelessWidget {
  const CustomDialog2({super.key});

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
              ElevatedButton(onPressed: () { showFirstWayDialogDialog1(context); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الأولى"),
              )),
              ElevatedButton(onPressed: () { showSecondWayDialogDialog1(context); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الثانية"),
              )),
              ElevatedButton(onPressed: () { showThirdWayDialogDialog1(context); }, child: const Padding(
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


void showFirstWayDialogDialog1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog3();
    },
  );
}

class CustomDialog3 extends StatelessWidget {
  CustomDialog3({super.key});

  final ClientsController controller = instance<ClientsController>();
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
                          controller.setFirstWay(priceController.text);
                          showLoading(context);
                          try {
                            await controller.resubscribe().then((value) {
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


void showSecondWayDialogDialog1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog4();
    },
  );
}

class CustomDialog4 extends StatelessWidget {
  CustomDialog4({super.key});

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
                            await controller.resubscribe().then((value) {
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


void showThirdWayDialogDialog1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog5();
    },
  );
}

class CustomDialog5 extends StatelessWidget {
  CustomDialog5({super.key});

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
                            await controller.resubscribe().then((value) {
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


