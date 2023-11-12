import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/main/masrofat/masrofat_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';

void showAddMasrofDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatelessWidget {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final MasrofatController controller = instance<MasrofatController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.add_masrouf,
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
                  TextFormField(
                    controller: amountController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.amount_masrouf_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.amount_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.description_masrouf_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.description_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
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
                    await controller.addMasrof(int.parse(amountController.text), descriptionController.text)
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
              child: const Text(AppStrings.add_masrof_button),
            ),
          ],
        ),
      ),
    );
  }

  CustomDialog({super.key});
}