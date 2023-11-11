import 'package:flutter/material.dart';

import '../common/state_renderer/state_renderer.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        // return const AlertDialog(
        //   title: Text("Please Wait..."),
        //   content: SizedBox(
        //       height: 50, child: Center(child: CircularProgressIndicator())
        //   ),
        // );
        return StateRenderer(
            stateRendererType: StateRendererType.popupLoadingState,
            message: "الرجاء الانتظار..",
            title: "loading",
            retryActionFunction: () { }
        );
      });
}