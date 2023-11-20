import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/presentation/main/terms/dialogs/add_term_dialog.dart';
import 'package:testt/presentation/main/terms/dialogs/edit_term_dialog.dart';
import 'package:testt/presentation/main/terms/terms_controller.dart';
import 'package:testt/presentation/main/terms/view_term.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../component/empty.dart';
import '../../resources/values_manager.dart';
import '../clients/clients_controller.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الفترات"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            showAddTermDialog(context);
          }),
      body: TermsList(),
    );
  }
}

class TermsList extends StatelessWidget {
  TermsList({super.key});
  
  final TermsController controller = instance<TermsController>();

  @override
  Widget build(BuildContext context) {
    controller.getTerms();
    return Obx(() {
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
              await controller.getTerms();
            });
      } else {
        if (controller.terms.value.isEmpty) {
          return emptyScreen(context, "لا يوجد فترات");
        } else {
          return ListView.builder(
            itemCount: controller.terms.value.length,
            itemBuilder: (context, index) {
              final item = controller.terms.value[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewTermView(term: item)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Card(
                    elevation: AppPadding.p8,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اسم الفترة: ${item.name}",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 23,
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s12,
                              ),
                              Text(
                                "بداية الفترة: ${item.start}\nنهاية الفترة: ${item.end}",
                                style: const TextStyle(
                                  color: Colors.black38,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  showEditTermDialog(context, item);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black38,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  return AwesomeDialog(
                                      btnCancelText: "الغاء",
                                      btnOkText: "حذف",
                                      context: context,
                                      dialogType: DialogType.noHeader,
                                      title: "حذف الفترة",
                                      desc: "هل أنت متأكد من حذف هذه الفترة ؟",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        await controller.delTerm(item);
                                      }).show();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
    });
  }
}
