import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/client.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';
import 'package:testt/presentation/main/clients/view_client_view.dart';
import 'package:testt/presentation/resources/routes_manager.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import '../../resources/values_manager.dart';

class ViewClientsView extends StatelessWidget {

  final ClientsController controller = instance<ClientsController>();
  final int kind;

  ViewClientsView({super.key, required this.kind});

  @override
  Widget build(BuildContext context) {
    (kind == 0) ? controller.getPersons() : (kind == 1) ? controller.getDealers() : controller.getClients();
    return Scaffold(
      appBar: AppBar(
        title: Text(kind == 0 ? "أفراد" : (kind == 1) ? "تجار" : "كل العملاء"),
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
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
              onChanged: (String query) {
                controller.searchClient(query);
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
                    message:
                    controller.error.value.replaceFirst("Exception: ", ""),
                    retryActionFunction: () async {
                      await controller.getClients();
                    });
              } else {
                if (controller.clients.value.isEmpty ||
                    controller.clients.value == List<Client>.empty()) {
                  return emptyScreen(context, "لا يوجد عملاء");
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                child: Text(
                                  "الإجمالى: ",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                child: Text(
                                  controller.sum.toString(),
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                child: Text(
                                  "العدد: ",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                child: Text(
                                  controller.clients.value.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(right: AppPadding.p8),
                              child: Center(
                                child: Text(
                                  "الاسم",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Center(
                                child: Text(
                                  "الهاتف",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Center(
                                child: Text(
                                  "النوع",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.clients.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: AppPadding.p8,
                                left: AppPadding.p8,
                                top: 5,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Client client = controller.clients[index];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewClientView(client: client)));
                                },
                                child: Card(
                                  color: const Color(0xFFf6f6f6),
                                  // elevation: AppSize.s8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p8),
                                              child: Text(
                                                controller
                                                    .clients[index].name,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p8),
                                              child: Text(
                                                controller.clients[index]
                                                    .phone,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p8),
                                              child: Text(
                                                controller
                                                    .clients[index].vegetableName,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
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
