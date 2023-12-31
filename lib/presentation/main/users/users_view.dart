import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/all_users.dart';
import 'package:testt/presentation/main/users/users_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import '../../resources/strings_manager.dart';

class UsersView extends StatelessWidget {
  UsersView({super.key});

  final UsersController controller = instance<UsersController>();

  @override
  Widget build(BuildContext context) {
    controller.getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.users_button),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "بحث",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1)
                  )
              ),
              onChanged: (String query) {
                controller.search(query);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return StateRenderer(
                    stateRendererType: StateRendererType.fullScreenLoadingState,
                    retryActionFunction: () {});
              } else if (controller.error.value != '') {
                return StateRenderer(
                    stateRendererType: StateRendererType.fullScreenErrorState,
                    message: controller.error.value.replaceFirst(
                        "Exception: ", ""),
                    retryActionFunction: () async {
                      await controller.getAllUsers();
                    });
              } else {
                if (controller.users.value.isEmpty) {
                  return emptyScreen(context, "لا يوجد عملاء");
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.users.value.length,
                            itemBuilder: (context, index) {
                              final item = controller.users.value[index];
                          return Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Card(
                            elevation: AppPadding.p8,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "اسم المستخدم: ",
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 20,
                                              )
                                          ),
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          )
                                        ]
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "رقم الهاتف: ",
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 20,
                                              )
                                          ),
                                          Text(
                                            item.phone,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  ElevatedButton(
                                      onPressed: () => {
                                        controller.toggleActive(item.id.toString())
                                      },
                                      child: Text(
                                          item.active == 0 ? "تفعيل" : "إلغاء تفعيل"
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                          );},
                        ),
                      ),
                    ],
                  );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
