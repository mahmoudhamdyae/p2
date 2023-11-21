import 'package:flutter/material.dart';
import 'package:testt/presentation/component/error.dart';

import '../../../../app/di.dart';
import '../clients_controller.dart';

void showSecondWayDialogDialog(BuildContext context) {
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
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
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
