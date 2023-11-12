import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';
import '../fridges_controller.dart';

void showAddAmberDialog(BuildContext context, int fridgeId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(fridgeId);
    },
  );
}

class CustomDialog extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final FridgesController controller = instance<FridgesController>();
  final int fridgeId;

  CustomDialog(this.fridgeId, {super.key});

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
              child: const Text(AppStrings.add_fridge_button),
            ),
          ],
        ),
      ),
    );
  }
}