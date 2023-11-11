import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/presentation/component/alert.dart';
import 'package:testt/presentation/component/error.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';


class AddFridgeView extends StatefulWidget {
  const AddFridgeView({Key? key}) : super(key: key);

  @override
  State<AddFridgeView> createState() => _AddFridgeViewState();
}

class _AddFridgeViewState extends State<AddFridgeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.add_fridge),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
          }
      ),
      body: const AddFridgeContent(),
    );
  }
}

class AddFridgeContent extends StatefulWidget {
  const AddFridgeContent({super.key});

  @override
  State<AddFridgeContent> createState() => _AddFridgeContentState();
}

class _AddFridgeContentState extends State<AddFridgeContent> {
  final ApiService _apiService = instance<ApiService>();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

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
                        await _apiService.addFridge(nameController.text)
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
                    AppStrings.add_fridge_button,
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
