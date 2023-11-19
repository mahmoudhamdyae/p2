import 'package:flutter/material.dart';
import 'package:testt/model/fridge.dart';

import '../../../../app/di.dart';
import '../../../../model/amber.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';
import '../fridges_controller.dart';

void showEditAmberDialog(BuildContext context, Amber amber, String fridgeId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(amber: amber, fridgeId: fridgeId,);
    },
  );
}

class CustomDialog extends StatefulWidget {
  final Amber amber;
  final String fridgeId;

  const CustomDialog({super.key, required this.amber, required this.fridgeId});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final FridgesController controller = instance<FridgesController>();

 @override
  void initState() {
    super.initState();
    nameController.text = widget.amber.name;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.edit_masrof_button,
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
                    await controller.updateAmber(widget.amber.id, nameController.text)
                        .then((userCredential) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      controller.showFridge(int.parse(widget.fridgeId));
                    });
                  } on Exception catch (e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showError(context, e.toString());
                  }
                }
              },
              child: const Text(AppStrings.edit_masrof_button),
            ),
          ],
        ),
      ),
    );
  }
}