import 'package:flutter/material.dart';
import 'package:testt/presentation/main/clients/dialogs/first_way_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/second_way_dialog_view.dart';
import 'package:testt/presentation/main/clients/dialogs/third_way_dialog_view.dart';


void showChoosePriceDialogDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

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
              ElevatedButton(onPressed: () { showFirstWayDialogDialog(context); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الأولى"),
              )),
              ElevatedButton(onPressed: () { showSecondWayDialogDialog(context); }, child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("الطريقة الثانية"),
              )),
              ElevatedButton(onPressed: () { showThirdWayDialogDialog(context); }, child: const Padding(
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
