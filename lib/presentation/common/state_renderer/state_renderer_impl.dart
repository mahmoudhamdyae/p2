import 'package:flutter/material.dart';
import 'package:testt/presentation/common/state_renderer/state_renderer.dart';

import '../../../app/constants.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}
// Loading state (POPUP,FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      { required this.stateRendererType, String message = AppStrings.loading });

  @override
  String getMessage() => message ?? AppStrings.loading.trim();

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// Empty State
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

// Success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState: {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // Show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // Show content ui of the screen
            return contentScreenWidget;
          } else {
            // Full screen loading state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState: {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // Show popup error
            showPopup(context, getStateRendererType(), getMessage());
            // Show content ui of the screen
            return contentScreenWidget;
          } else {
            // Full screen error state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case EmptyState: {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case ContentState: {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case SuccessState: {
          // Check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // Show popup
          showPopup(context, StateRendererType.popupSuccess, getMessage(),
              title: AppStrings.success);
          // Return content ui of the screen
          return contentScreenWidget;
        }
      default: {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryActionFunction: () {})));
  }
}