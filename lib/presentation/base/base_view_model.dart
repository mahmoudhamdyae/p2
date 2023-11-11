import 'dart:async';

import '../common/state_renderer/state_renderer_impl.dart';

class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {

  // Shared variables and function that will be used through any view model.
  final StreamController _inputStreamController =
    StreamController<FlowState>.broadcast();//BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }
}

abstract class BaseViewModelInputs {
  void start(); // Start view model job

  void dispose(); // Will be called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}