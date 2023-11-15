import 'package:get/get.dart';
import 'package:testt/app/personal_data.dart';
import 'package:testt/data/services/api_service.dart';

class PersonalDataController extends GetxController {
  final ApiService _apiService;

  Rx<PersonalData> personalData = PersonalData("", "0", 0).obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  PersonalDataController(this._apiService);

  Future getPersonalData() async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.getPersonalData().then((value) {
        personalData.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}