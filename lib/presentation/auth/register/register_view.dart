import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../data/services/account_service.dart';
import '../../component/alert.dart';
import '../../component/error.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final AccountService _accountService = instance<AccountService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();

      try {
        showLoading(context);
        await _accountService.signUp(nameController.text, passController.text, confirmPassController.text, numberController.text)
            .then((userCredential) {
              _accountService.logIn(numberController.text, passController.text).then((value) {
                _appPreferences.setUserLoggedIn();
                Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
              });
        });
      } on Exception catch (e) {
        Navigator.of(context).pop();
        showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
                height: AppSize.s300,
                width: AppSize.s300,
                child: Lottie.asset(JsonAssets.auth)
            ),
          ),
          Container(
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
                          return AppStrings.userNameInvalid;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: AppStrings.username,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    TextFormField(
                      controller: numberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val.toString().length == 11 &&
                            val.toString().startsWith("01")) {
                          return null;
                        }
                        return AppStrings.mobileNumberInvalid;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: AppStrings.phone,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    TextFormField(
                      controller: passController,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return AppStrings.passwordError;
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _toggle();
                            },
                          ),
                          hintText: AppStrings.password,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    TextFormField(
                      controller: confirmPassController,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val != passController.text) {
                          return AppStrings.passwordConfirmInvalid;
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _toggle();
                            },
                          ),
                          hintText: AppStrings.passwordConfirm,
                          border: const OutlineInputBorder(
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
                          await signUp();
                        },
                        child: Text(
                          AppStrings.register,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppStrings.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.titleMedium),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
