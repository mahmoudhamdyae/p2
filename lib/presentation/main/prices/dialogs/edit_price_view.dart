import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/model/price.dart';
import 'package:testt/presentation/main/prices/prices_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/di.dart';
import '../../../component/alert.dart';
import '../../../component/error.dart';
import '../../../resources/strings_manager.dart';
import '../../fridges/dialogs/add_ambar_dialog.dart';

void showEditPriceDialog(BuildContext context, Price price) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(price: price);
    },
  );
}

class CustomDialog extends StatefulWidget {
  final Price price;

  const CustomDialog({super.key, required this.price});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}


class _CustomDialogState extends State<CustomDialog> {
  TextEditingController vegetableNameController = TextEditingController();
  TextEditingController tonController = TextEditingController();
  TextEditingController smallShakaraController = TextEditingController();
  TextEditingController bigShakaraController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final PricesController controller = instance<PricesController>();

  @override
  void initState() {
    super.initState();
    vegetableNameController.text = widget.price.vegetableName;
    tonController.text = widget.price.ton;
    smallShakaraController.text = widget.price.small_shakara;
    bigShakaraController.text = widget.price.big_shakara;
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
              "تعديل السعر",
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
                    controller: vegetableNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_vegetable_name_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_vegetable_name_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tonController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_ton_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_ton_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bigShakaraController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_big_shakara_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_big_shakara_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: smallShakaraController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_vegetable_name_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_small_shakara_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
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
                    await controller.updatePrice(
                        widget.price.id,
                        vegetableNameController.text,
                        int.parse(smallShakaraController.text),
                        int.parse(bigShakaraController.text),
                        int.parse(tonController.text)
                    )
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
              child: const Text("تعديل السعر",),
            ),
          ],
        ),
      ),
    );
  }


/*
class CustomDialog extends StatelessWidget {
  TextEditingController vegetableNameController = TextEditingController();
  TextEditingController tonController = TextEditingController();
  TextEditingController smallShakaraController = TextEditingController();
  TextEditingController bigShakaraController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final PricesController controller = instance<PricesController>();

  final Price price;

  CustomDialog({super.key, required this.price});

  @override
  void initState() {
    super.initState();
    vegetableNameController.text = widget.fridge.name;
    tonController.text = widget.fridge.name;
    smallShakaraController.text = widget.fridge.name;
    bigShakaraController.text = widget.fridge.name;
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
              "تعديل السعر",
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
                    controller: vegetableNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_vegetable_name_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_vegetable_name_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: tonController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_ton_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_ton_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bigShakaraController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_big_shakara_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_big_shakara_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: smallShakaraController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return AppStrings.prices_vegetable_name_invalid;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: AppStrings.prices_small_shakara_hint,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(height: 16),
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
                    await controller.updatePrice(
                      price.id, vegetableNameController.text, int.parse(smallShakaraController.text), int.parse(bigShakaraController.text), int.parse(tonController.text)
                    )
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
              child: const Text("تعديل السعر",),
            ),
          ],
        ),
      ),
    );
  }
}*/
}
