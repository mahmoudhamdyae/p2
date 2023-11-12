import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/model/masrofat.dart';
import 'package:testt/presentation/main/masrofat/masrofat_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';

void showEditMasrofDialog(BuildContext context, Masrofat masrofat) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(masrofat: masrofat);
    },
  );
}

class CustomDialog extends StatefulWidget {
  final Masrofat masrofat;

  const CustomDialog({super.key, required this.masrofat});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final MasrofatController controller = instance<MasrofatController>();

  @override
  void initState() {
    super.initState();
    amountController.text = widget.masrofat.amount;
    descriptionController.text = widget.masrofat.description;
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
              AppStrings.edit_fridge,
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
                    height: AppPadding.p16,
                  ),
                  TextFormField(
                    controller: amountController,
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
                    await controller.updateMasrof(widget.masrofat.id, int.parse(amountController.text) , descriptionController.text)
                        .then((userCredential) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      // controller.getMasrofat();
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