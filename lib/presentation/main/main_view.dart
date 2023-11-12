import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../data/services/account_service.dart';
import '../resources/routes_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final AccountService _accountService = instance<AccountService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                AwesomeDialog(
                    btnCancelText: "الغاء",
                    btnOkText: "تسجيل خروج",
                    context: context,
                    dialogType: DialogType.noHeader,
                    title: "تسجيل خروج",
                    desc: "هل أنت متأكد من تسجيل الخروج ؟",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      _accountService.signOut().then((value) {
                        _appPreferences.logout();
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute);
                      });
                    }).show();
              })
        ],
      ),
      body: const MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p48,
        bottom: AppPadding.p48,
        left: AppPadding.p32,
        right: AppPadding.p32,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Row(
            children: [
              // عملاء
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, Routes.fridgesRoute)
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people,
                                  size: 65,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(
                                height: AppSize.s32,
                              ),
                              Text(
                                AppStrings.clients_button,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 25,
                                ),
                              ),
                            ])),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s32,
              ),
              // مصروفات
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(context, Routes.fridgesRoute)
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money,
                                size: 65,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              height: AppSize.s32,
                            ),
                            Text(
                              AppStrings.masrofat_button,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 25,
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s32,
        ),
        Expanded(
          child: Row(
            children: [
              // تقارير
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3)
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () => {
                        // Navigator.pushNamed(context, Routes.pricesRoute)
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bar_chart,
                              size: 65, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            height: AppSize.s32,
                          ),
                          Text(
                            AppStrings.reports_button,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s32,
              ),
              // إعدادات
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, Routes.settingsRoute)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,
                              size: 65, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            height: AppSize.s32,
                          ),
                          Text(
                            AppStrings.settings_button,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
