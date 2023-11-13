import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
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
                // عملاء
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, Routes.clientsRoute)
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people,
                                  size: 65,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(
                                width: AppSize.s32,
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
                  height: AppSize.s32,
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money,
                                  size: 65,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(
                                width: AppSize.s32,
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
                const SizedBox(
                  height: AppSize.s32,
                ),
                // تقارير
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, Routes.reportsRoute)
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bar_chart,
                                size: 65, color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: AppSize.s32,
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
                  height: AppSize.s32,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.settings,
                                size: 65, color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: AppSize.s32,
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
      )
    );
  }
}
