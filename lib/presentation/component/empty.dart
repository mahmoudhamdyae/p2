import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

emptyScreen(context, String message) {
  return _getItemsColumn(
      [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
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