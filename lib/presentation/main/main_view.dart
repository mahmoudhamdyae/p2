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
      padding: const EdgeInsets.all(AppPadding.p32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Row(
            children: [
              // مصروفات
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Container background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset in the x, y axis
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
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor, // Use the primary color
                            borderRadius:
                                BorderRadius.circular(10), // Set the border radius
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.attach_money,
                                    size: 50,
                                    color: Theme.of(context).secondaryHeaderColor),
                                const Text(
                                  AppStrings.masrofat_button,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )
                              ]),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s32,
              ),
              // عملاء
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GestureDetector(
                      onTap: () =>
                      {Navigator.pushNamed(context, Routes.fridgesRoute)},
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          Theme.of(context).primaryColor, // Use the primary color
                          borderRadius:
                          BorderRadius.circular(10), // Set the border radius
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.people,
                                  size: 50,
                                  color: Theme.of(context).secondaryHeaderColor),
                              const Text(
                                AppStrings.clients_button,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                      )),
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
              // إعدادات
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GestureDetector(
                    onTap: () => {
                      // Navigator.pushNamed(context, Routes.pricesRoute)
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).primaryColor, // Use the primary color
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.settings,
                              size: 50, color: Theme.of(context).secondaryHeaderColor),
                          const Text(
                            AppStrings.settings_button,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s32,
              ),
              // تقارير
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GestureDetector(
                    onTap: () => {
                      // Navigator.pushNamed(context, Routes.pricesRoute)
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                        Theme.of(context).primaryColor, // Use the primary color
                        borderRadius:
                        BorderRadius.circular(10), // Set the border radius
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.bar_chart,
                              size: 50, color: Theme.of(context).secondaryHeaderColor),
                          const Text(
                            AppStrings.reports_button,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
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
