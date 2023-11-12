import 'dart:convert';
import 'dart:core';

import 'package:testt/model/fridge.dart';
import 'package:http/http.dart' as http;
import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network/network_info.dart';

abstract class ApiService {
  Future<List<Fridge>> getFridges();
  Future addFridge(String name);
  Future delFridge(int id);
  Future updateFridge(int id, String name);
  Future showFridge(int id);
  Future addAmber(int fridgeId, String anbarName);
}

class ApiServiceImpl implements ApiService {
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  ApiServiceImpl(this._networkInfo, this._appPreferences);

  _checkNetwork() async {
    if (await _networkInfo.isConnected) {
    } else {
      throw Exception(AppStrings.noInternetError);
    }
  }

  @override
  Future<List<Fridge>> getFridges() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}fridge";
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);

    List<Fridge> fridges = [];
    for (var singleFridge in responseData["fridge"]) {
      Fridge fridge = Fridge.fromJson(singleFridge);

      // Adding user to the list.
      fridges.add(fridge);
    }
    return fridges;
  }

  @override
  Future addFridge(String name) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}fridge?name=$name";
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    await json.decode(response.body);
  }

  @override
  Future delFridge(int id) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}fridge/$id/delete";
    final response = await http.delete(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    await json.decode(response.body);
  }

  @override
  Future updateFridge(int id, String name) async {

    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}fridge/$id/edit?name=$name";
    final response = await http.put(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );

    _checkServer(response);
    await json.decode(response.body);
  }

  @override
  Future addAmber(int fridgeId, String anbarName) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}amber/$fridgeId?name=$anbarName";
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    await json.decode(response.body);
  }

  _checkServer(http.Response response) {
    if (response.statusCode != 200) {
      throw (Exception("لا يمكن الاتصال بالسيرفر"));
    }
  }

  @override
  Future showFridge(int id) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}fridge/$id/show";
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);
    print("============== response data ---- $responseData");
    print("============== response data status ---- ${responseData["status"]}");
    print("============== response data fridge ---- ${responseData["fridge"]}");
    print("============== response data name ---- ${responseData["fridge"]["name"]}");
    print("============== response data size ---- ${responseData["fridge"]["size"]}");
    print("============== response data user_id ---- ${responseData["fridge"]["user_id"]}");
    print("============== response data ambers ---- ${responseData["fridge"]["ambers"]}");
    print("============== response data owner name ---- ${responseData["fridge"]["owner"]["name"]}");
  }
}