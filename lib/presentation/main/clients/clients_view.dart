import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class ClientsView extends StatelessWidget {

  final ClientsController controller = instance<ClientsController>();

  ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.clients_button),
      ),
    body: Padding(
      padding: const EdgeInsets.all(AppPadding.p32),
      child: Column(
        children: [
          Expanded(child: Container()),
          // العملاء
          Expanded(
            child: GestureDetector(
              onTap: () =>
              {
                Navigator.pushNamed(context, Routes.clients2Route)
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
                            size: 65,
                            color: Theme
                                .of(context)
                                .primaryColor),
                        const SizedBox(
                          width: AppSize.s40,
                        ),
                        Text(
                          "العملاء",
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
          // الفترات
          Expanded(
            child: GestureDetector(
              onTap: () =>
              {
                // Navigator.pushNamed(context, Routes.pricesRoute)
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
                        Icon(Icons.schedule_sharp,
                            size: 65,
                            color: Theme
                                .of(context)
                                .primaryColor),
                        const SizedBox(
                          width: AppSize.s32,
                        ),
                        Text(
                          "الفترات",
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
          Expanded(child: Container()),
        ],
      ),
    ),
    );
  }
}
