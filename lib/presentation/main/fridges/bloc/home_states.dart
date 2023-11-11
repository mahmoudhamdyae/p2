import 'package:testt/model/fridge.dart';

class HomeStates {
}

class InitialState extends HomeStates {
}

class UpdateState extends HomeStates {
  final List<Fridge> fridges;
  UpdateState(this.fridges);
}