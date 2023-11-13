import 'dart:convert';
import 'dart:core';

import 'package:testt/model/fridge.dart';
import 'package:http/http.dart' as http;
import 'package:testt/model/masrofat.dart';
import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network/network_info.dart';

abstract class ApiService {
  Future<List<Fridge>> getFridges();
  Future addFridge(String name);
  Future delFridge(int id);
  Future updateFridge(int id, String name);
  Future<Fridge> showFridge(int id);
  Future addAmber(int fridgeId, String anbarName);

  Future<(List<Masrofat>, int)> getMasrofat();
  Future addMasrof(int amount, String description);
  Future updateMasrof(int masrofId, int amount, String description);
  Future<Masrofat> showMasrof(int masrofId);
  Future delMasrof(int masrofId);
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
  Future<Fridge> showFridge(int id) async {
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
    return Fridge.fromJson(responseData["fridge"]);
  }

  @override
  Future<(List<Masrofat>, int)> getMasrofat() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense";
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
    print("=========res data sunm ${responseData["sum"]}");
    List<Masrofat> masrofat = [];
    for (var singleMasrof in responseData["expense"]) {
      Masrofat masrof = Masrofat.fromJson(singleMasrof);
      masrofat.add(masrof);
    }
    return (masrofat, responseData["sum"] as int);
  }

  @override
  Future addMasrof(int amount, String description) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense?amount=$amount&description=$description";
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
  Future delMasrof(int masrofId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense/$masrofId/delete";
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
  Future<Masrofat> showMasrof(int masrofId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense/$masrofId/show";
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
    return Masrofat.fromJson(responseData["expense"]);
  }

  @override
  Future updateMasrof(int masrofId, int amount, String description) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense/$masrofId/edit?amount=$amount&description=$description";
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
}