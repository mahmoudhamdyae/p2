import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';

import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class Clients2View extends StatelessWidget {
  Clients2View({super.key});
  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addClientRoute);
        },
      ),
      appBar: AppBar(
        title: const Text("عملاء"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p32),
        child: Column(
          children: [
            Expanded(flex: 1, child: Container()),
            // أفراد
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () =>
                {
                  // Navigator.pushNamed(context, Routes.clients2Route)
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
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: AppPadding.p8),
                            child: Text(
                              "أفراد",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 32,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p8),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 38,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),

                        ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s32,
            ),
            // التجار
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () =>
                {
                  // Navigator.pushNamed(context, Routes.clients2Route)
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
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: AppPadding.p8),
                            child: Text(
                              "التجار",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 32,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p8),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 38,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),

                        ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s32,
            ),
            // كل العملاء
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () =>
                {
                  // Navigator.pushNamed(context, Routes.clients2Route)
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
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: AppPadding.p8),
                            child: Text(
                              "كل العملاء",
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 32,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p8),
                            child: Icon(Icons.arrow_forward_ios,
                                size: 38,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),

                        ]),
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}
