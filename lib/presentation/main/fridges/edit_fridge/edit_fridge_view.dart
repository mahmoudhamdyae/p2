import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/component/alert.dart';
import 'package:testt/presentation/component/error.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';


class EditFridgeView extends StatefulWidget {
  final Fridge? fridge;
  const EditFridgeView({Key? key, required this.fridge}) : super(key: key);

  @override
  State<EditFridgeView> createState() => _EditFridgeViewState();
}

class _EditFridgeViewState extends State<EditFridgeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.edit_fridge),
      ),
      body: widget.fridge == null ? Container() : AddFridgeContent(fridge: widget.fridge!,),
    );
  }
}

class AddFridgeContent extends StatefulWidget {
  final Fridge fridge;
  const AddFridgeContent({super.key, required this.fridge});

  @override
  State<AddFridgeContent> createState() => _AddFridgeContentState();
}

class _AddFridgeContentState extends State<AddFridgeContent> {
  final ApiService _apiService = instance<ApiService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.fridge.name;
    sizeController.text = widget.fridge.size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Form(
          key: formState,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.fridge_name_invalid;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: AppStrings.fridge_name_hint,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              TextFormField(
                controller: sizeController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.fridge_size_invalid;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: AppStrings.fridge_size_hint,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1))),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: ElevatedButton(
                  onPressed: () async {
                    var formData = formState.currentState;
                    if (formData!.validate()) {
                      formData.save();
                      try {
                        showLoading(context);
                        await _apiService.updateFridge(
                            widget.fridge.id,
                            nameController.text,
                            sizeController.text
                        )
                            .then((userCredential) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      } on Exception catch (e) {
                        Navigator.of(context).pop();
                        showError(context, e.toString());
                      }
                    }
                  },
                  child: Text(
                    AppStrings.edit_fridge_button,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
