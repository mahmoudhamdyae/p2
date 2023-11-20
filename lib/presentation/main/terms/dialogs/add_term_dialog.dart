import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/main/terms/terms_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';

void showAddTermDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TermsController controller = instance<TermsController>();

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
                    await controller.addTerm(nameController.text, startController.text, endController.text)
                        .then((userCredential) {
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
              child: const Text("إضافة الفترة"),
            ),
          ],
        ),
      ),
    );
  }

  CustomDialog({super.key});
}