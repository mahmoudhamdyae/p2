import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/main/fridges/bloc/home_events.dart';

import 'home_states.dart';

class FridgesBloc extends Bloc<HomeEvents, HomeStates> {

  final ApiService _apiService;

  List<Fridge> fridges = [];

  FridgesBloc(this._apiService) : super(InitialState()) {
    on<GetFridges>(onGetFridges);
  }

  void onGetFridges(
      GetFridges event, Emitter<HomeStates> emit) async {
    fridges = await _apiService.getFridges();
    emit(UpdateState(fridges));
  }
}