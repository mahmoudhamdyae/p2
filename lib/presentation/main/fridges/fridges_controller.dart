import 'package:get/get.dart';
import 'package:testt/model/amber.dart';

import '../../../data/services/api_service.dart';
import '../../../model/fridge.dart';

class FridgesController extends GetxController {

  final ApiService _apiService;
  RxList<Fridge> fridges = List<Fridge>.empty().obs;
  Rx<Fridge> fridge = Fridge(0, "", "", -1, Owner(""), []).obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  FridgesController(this._apiService);

  Future<void> getFridges() async {
    try {
      isLoading.value = true;
      fridges.value = List<Fridge>.empty();
      error.value = '';
      await _apiService.getFridges().then((value) {
        fridges.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      fridges.value = List<Fridge>.empty();
      isLoading.value = false;
    }
  }

  Future<void> delFridge(Fridge fridge) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.delFridge(fridge.id).then((value) {
        fridges.value.remove(fridge);
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      fridges.value = List<Fridge>.empty();
      isLoading.value = false;
    }
  }

  Future<void> addFridge(String fridgeName) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addFridge(fridgeName).then((value) {
        fridges.value.add(Fridge(44, fridgeName, "0", 0, Owner(""), []));
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      fridges.value = List<Fridge>.empty();
      isLoading.value = false;
    }
  }

  Future<void> updateFridge(int fridgeId, String fridgeName, String amberName) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.updateFridge(fridgeId, amberName).then((value) {
        fridges.value = fridges.value.map((fridge) {
          if (fridge.id == fridgeId) {
            return Fridge(fridge.id, fridgeName, fridge.size, fridge.userId, fridge.owner, fridge.ambers);
          } else {
            return fridge;
          }
        }).toList();
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      fridges.value = List<Fridge>.empty();
      isLoading.value = false;
    }
  }

  Future<void> addAnbar(int fridgeId, String amberName) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addAmber(fridgeId, amberName).then((value) {
        fridges.value = fridges.value.map((fridge) {
          if (fridge.id == fridgeId) {
            return Fridge(fridge.id, fridge.name, (int.parse(fridge.size) + 1).toString(), fridge.userId, fridge.owner, fridge.ambers);
          } else {
            return fridge;
          }
        }).toList();
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      fridges.value = List<Fridge>.empty();
      isLoading.value = false;
    }
  }

  Future<void> showFridge(int fridgeId) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.showFridge(fridgeId).then((fridgeApi) {
        fridge.value = fridgeApi;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future<void> delAmber(Amber amber) async {
    try {
      isLoading.value = true;
      // error.value = '';
      await _apiService.delAmber(amber.id).then((value) {
        showFridge(fridge.value.id);
        error.value = '';
        // isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future<void> updateAmber(int amberId) async {
    try {
      // isLoading.value = true;
      // error.value = '';
      await _apiService.updateAmber(amberId).then((value) {
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}