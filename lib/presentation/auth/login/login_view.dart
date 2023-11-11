import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testt/presentation/component/error.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../data/services/account_service.dart';
import '../../component/alert.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final AccountService _accountService = instance<AccountService>();

  String? number, password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController passwordTextController = TextEditingController();
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  logIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        showLoading(context);
        await _accountService.logIn(number!, password!).then((userCredential) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      onSaved: (val) {
                        number = val;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val.toString().isNotEmpty) {
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
                      onSaved: (val) {
                        password = val;
                      },
                      textInputAction: TextInputAction.done,
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
                    SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: () async {
                          await logIn();
                        },
                        child: Text(
                          AppStrings.login,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(AppStrings.registerText,
                              style:
                              Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
