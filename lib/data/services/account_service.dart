import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testt/app/constants.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../app/app_prefs.dart';
import '../network/network_info.dart';

abstract class AccountService {
  Future signUp(String userName, String password, String repeatedPassword, String phone);
  Future logIn(String phone, String password);
  Future signOut();
}

class AccountServiceImpl implements AccountService {

  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  AccountServiceImpl(this._networkInfo, this._appPreferences);

  @override
  Future signUp(
      String userName,
      String password,
      String repeatedPassword,
      String phone
      )  async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/register?name=$userName&password=$password&password_confirmation=$repeatedPassword&phone=$phone";
    final response = await http.post(Uri.parse(url));
    _checkServer(response);

    final responseData = await json.decode(response.body);
    if (responseData["message"] == null) {
      throw Exception("هذا الرقم مسجل مسبقا");
    }
  }

  @override
  Future logIn(String phone, String password)  async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/login?&password=$password&phone=$phone";
    final response = await http.post(Uri.parse(url));
    _checkServer(response);

    var responseData = json.decode(response.body);
    if (responseData["access_token"] == null) {
      throw Exception("رقم الهاتف أو كلمة المرور خاطئة");
    }
    _appPreferences.setToken(responseData["access_token"]);
  }

  @override
  Future signOut() async {
    _appPreferences.setToken("");
  }

  _checkNetwork() async {
    if (await _networkInfo.isConnected) {
    } else {
      throw Exception(AppStrings.noInternetError);
    }
  }

  _checkServer(http.Response response) {
    if (response.statusCode != 200) {
      throw (Exception("لا يمكن الاتصال بالسيرفر"));
    }
  }

}