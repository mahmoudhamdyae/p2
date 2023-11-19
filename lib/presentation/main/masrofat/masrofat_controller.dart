import 'package:get/get.dart';
import 'package:testt/model/masrofat.dart';
import 'package:uuid/uuid.dart';

import '../../../data/services/api_service.dart';

class MasrofatController extends GetxController {
  final ApiService _apiService;
  RxList<Masrofat> masrofat = List<Masrofat>.empty().obs;
  Rx<Masrofat> masrof = Masrofat(-1, "", "", "").obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;
  Rx<int> sum = 0.obs;

  MasrofatController(this._apiService);

  Future getMasrofat() async {
    try {
      isLoading.value = true;
      masrofat.value = List<Masrofat>.empty();
      error.value = '';
      await _apiService.getMasrofat().then((value) {
        masrofat.value = value.$1;
        sum.value = value.$2;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      masrofat.value = List<Masrofat>.empty();
      isLoading.value = false;
    }
  }

  Future addMasrof(int amount, String description) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addMasrof(amount, description).then((value) {
        masrofat.value.add(Masrofat(int.parse(const Uuid().v4.toString()), amount.toString(), description, ""));
        error.value = '';
        isLoading.value = false;
        getMasrofat();
      });
    } on Exception catch (e) {
      // error.value = e.toString();
      isLoading.value = false;
      getMasrofat();
    }
  }

  Future updateMasrof(int masrofId, int amount, String description) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.updateMasrof(masrofId, amount, description).then((value) {
        masrofat.value = masrofat.value.map((masrof) {
          if (masrof.id == masrofId) {
            return Masrofat(masrofId, amount.toString(), description, masrof.date);
          } else {
            return masrof;
          }
        }).toList();
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future showMasrof(int masrofId) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.showMasrof(masrofId).then((value) {
        masrof.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future delMasrof(int masrofId) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.delMasrof(masrofId).then((value) {
        masrofat.value.remove(value);
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future search(String query) async {
    try {
      // isLoading.value = true;
      error.value = '';
      await _apiService.searchMasrofat(query).then((value) {
        masrofat.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}