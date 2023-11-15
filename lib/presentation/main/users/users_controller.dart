import 'package:get/get.dart';
import 'package:testt/model/all_users.dart';

import '../../../data/services/api_service.dart';

class UsersController extends GetxController {
  final ApiService _apiService;
  RxList<AllUsers> users = List<AllUsers>.empty().obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  UsersController(this._apiService);

  Future getAllUsers() async {
    try {
      isLoading.value = true;
      users.value = List<AllUsers>.empty();
      error.value = '';
      await _apiService.getUsers().then((value) {
        users.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      users.value = List<AllUsers>.empty();
      isLoading.value = false;
    }
  }

  Future toggleActive(String userId) async {
    try {
      isLoading.value = true;
      users.value = List<AllUsers>.empty();
      error.value = '';
      await _apiService.toggleActive(userId).then((value) {
        users.value = users.value.map((user) {
        if (user.id == userId) {
          final active = user.active == 0 ? 1 : 0;
          return AllUsers(user.id, user.name, user.phone, active);
      } else {
        return user;
        }
        }).toList();
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      users.value = List<AllUsers>.empty();
      isLoading.value = false;
    }
  }
}