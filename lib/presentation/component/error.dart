import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../common/state_renderer/state_renderer.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

showError(context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return StateRenderer(
            stateRendererType: StateRendererType.popupErrorState,
            message: message.replaceFirst("Exception: ", ""),
            title: message,
            retryActionFunction: () { }
        );
      });
}

showFullError(context, String message, Function retryActionFunction) {
  print("==================error $message");
  return _getItemsColumn([
    _getAnimatedImage(JsonAssets.error),
    _getMessage(message),
    _getRetryButton(AppStrings.retryAgain.trim(), context, retryActionFunction)
  ]);
}

Widget _getItemsColumn(List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getAnimatedImage(String animationName) {
  return Padding(
    padding: const EdgeInsets.all(AppPadding.p16),
    child: SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName)
    ),
  );
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: getRegularStyle(
            color: ColorManager.black, fontSize: FontSize.s18),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _getRetryButton(String buttonTitle, BuildContext context, Function retryActionFunction) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                  // Call retry function
                  retryActionFunction.call();
              },
              child: Text(buttonTitle))),
    ),
  );
}