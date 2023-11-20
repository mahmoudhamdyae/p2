import 'package:flutter/material.dart';
import 'package:testt/presentation/main/terms/terms_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../../app/di.dart';
import '../../../../model/term.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';

void showEditTermDialog(BuildContext context, Term term) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(term: term);
    },
  );
}

class CustomDialog extends StatefulWidget {
  final Term term;

  const CustomDialog({super.key, required this.term});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final TermsController controller = instance<TermsController>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.term.name;
    startController.text = widget.term.start;
    endController.text = widget.term.end;
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
              "تعديل الفترة",
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
                    await controller.updateTerm(widget.term.id.toString() , nameController.text, startController.text, endController.text)
                        .then((userCredential) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      controller.getTerms();
                    });
                  } on Exception catch (e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showError(context, e.toString());
                  }
                }
              },
              child: const Text("تعديل الفترة"),
            ),
          ],
        ),
      ),
    );
  }
}