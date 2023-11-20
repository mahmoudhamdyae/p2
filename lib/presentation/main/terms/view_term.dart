import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/terms/terms_controller.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../model/term.dart';
import '../../common/state_renderer/state_renderer.dart';

class ViewTermView extends StatelessWidget {
  TermsController controller = instance<TermsController>();
  final Term term;

  ViewTermView({super.key, required this.term});

  @override
  Widget build(BuildContext context) {
    controller.showTerm(term.id.toString());
    controller.showTerm(term.id.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(term.name),
      ),
      body: Obx(() {
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
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "اسم الفترة: ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppSize.s24
                      ),
                    ),
                    Text(
                      controller.term.value.name,
                      style: const TextStyle(
                          fontSize: AppSize.s24
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                Row(
                  children: [
                    Text(
                      "بداية الفترة: ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppSize.s24
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}