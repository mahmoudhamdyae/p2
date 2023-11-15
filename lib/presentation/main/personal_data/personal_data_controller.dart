import 'package:get/get.dart';
import 'package:testt/app/personal_data.dart';
import 'package:testt/data/services/api_service.dart';

class PersonalDataController extends GetxController {
  final ApiService _apiService;

  Rx<PersonalData> personalData = PersonalData("", "0", 0).obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;
  Rx<bool> obscureText = true.obs;

  PersonalDataController(this._apiService);

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

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

  Future updatePersonalData(String name, String phone, String password, String confirmPassword) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.updatePersonalData(name, phone, password, confirmPassword).then((value) {
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}