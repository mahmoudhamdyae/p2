import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import '../clients_controller.dart';

void showFirstWayDialogDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatelessWidget {
  CustomDialog({super.key});

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
                        keyboardType: TextInputType.text,
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
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop();
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

























void showEditFirstWayDialogDialog(BuildContext context, String quantity, String price ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog2(quantity: quantity, price: price);
    },
  );
}

class CustomDialog2 extends StatelessWidget {
  String quantity;
  String price;
  CustomDialog2({super.key, required this.quantity, required this.price});

  final ClientsController controller = instance<ClientsController>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    quantityController.text = quantity;
    priceController.text = price;
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
                        keyboardType: TextInputType.text,
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
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop();
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
