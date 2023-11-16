import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../data/services/account_service.dart';
import '../resources/assets_manager.dart';
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
      body: Stack(
          fit: StackFit.expand,
          children: [
          Image.asset(
            ImageAssets.backgroundImage, // Replace with your image path
            fit: BoxFit.fill,
          ),
          FutureBuilder(
          future: _appPreferences.getIsActive(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const MainContent();
              } else {
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            "هذا الحساب غير مفعل\nبرجاء التواصل معنا من خلال",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppSize.s24
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s16,
                        ),
                        const Text(
                          "مكالمات & واتساب:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: AppSize.s24
                          ),
                        ),
                        Text(
                          "01080760364",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: AppSize.s24
                          ),
                        ),
                      ],
                    )
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ]),
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
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, Routes.clientsRoute)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: Colors.white.withOpacity(.8),
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
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSize.s32,
              ),
              // مصروفات
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, Routes.masrofatRoute)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: Colors.white.withOpacity(.8),
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
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, Routes.reportsRoute)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: Colors.white.withOpacity(.8),
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
                      color: Colors.white.withOpacity(.8),
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
