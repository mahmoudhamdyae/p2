import 'package:get/get.dart';
import 'package:testt/model/masrofat.dart';

import '../../../data/services/api_service.dart';

class MasrofatController extends GetxController {
  final ApiService _apiService;
  RxList<Masrofat> masrofat = List<Masrofat>.empty().obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  MasrofatController(this._apiService);

  Future getMasrofat() async {
    try {
      isLoading.value = true;
      masrofat.value = List<Masrofat>.empty();
      error.value = '';
      await _apiService.getMasrofat().then((value) {
        masrofat.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      masrofat.value = List<Masrofat>.empty();
      isLoading.value = false;
    }
  }
}