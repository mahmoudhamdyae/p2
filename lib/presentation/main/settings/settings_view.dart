import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.settings_title),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              ImageAssets.backgroundImage, // Replace with your image path
              fit: BoxFit.fill,
            ),
            Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p48,
              bottom: AppPadding.p48,
              left: AppPadding.p32,
              right: AppPadding.p32,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Column(
                    children: [
                      // الثلاجات
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                          {
                            Navigator.pushNamed(context, Routes.fridgesRoute)
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
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.kitchen,
                                        size: 65,
                                        color: Theme
                                            .of(context)
                                            .primaryColor),
                                    const SizedBox(
                                      width: AppSize.s32,
                                    ),
                                    Text(
                                      AppStrings.fridges_button,
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s32,
                      ),
                      // قائمة الأسعار
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                          {
                            Navigator.pushNamed(context, Routes.pricesRoute)
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
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.list,
                                        size: 65,
                                        color: Theme
                                            .of(context)
                                            .primaryColor),
                                    const SizedBox(
                                      width: AppSize.s32,
                                    ),
                                    Text(
                                      AppStrings.prices_button,
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontSize: 25,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s32,
                      ),
                      // البيانات الشخصية
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                          {
                            Navigator.pushNamed(context, Routes.personalDataRoute)
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,
                                      size: 65, color: Theme
                                          .of(context)
                                          .primaryColor),
                                  const SizedBox(
                                    width: AppSize.s32,
                                  ),
                                  Text(
                                    AppStrings.personal_data_button,
                                    style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
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
                        height: AppSize.s32,
                      ),
                      // المستخدمين
                      Users(),
                    ],
                  ),
                ),
            ]),
          )],
        )
    );
  }
}

class Users extends StatelessWidget {
  final pref = instance<AppPreferences>();

  Users({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: pref.getIsAdmin(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Expanded(
              child: GestureDetector(
                onTap: () =>
                {
                  Navigator.pushNamed(context, Routes.usersRoute)
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people,
                            size: 65, color: Theme
                                .of(context)
                                .primaryColor),
                        const SizedBox(
                          width: AppSize.s32,
                        ),
                        Text(
                          AppStrings.users_button,
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}


