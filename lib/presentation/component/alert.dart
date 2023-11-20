import 'package:flutter/material.dart';

import '../common/state_renderer/state_renderer.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StateRenderer(
            stateRendererType: StateRendererType.popupLoadingState,
            message: "الرجاء الانتظار..",
            title: "loading",
            retryActionFunction: () { }
        );
      });
}