import 'dart:convert';
import 'dart:core';

import 'package:testt/app/personal_data.dart';
import 'package:testt/model/all_users.dart';
import 'package:testt/model/fridge.dart';
import 'package:http/http.dart' as http;
import 'package:testt/model/masrofat.dart';
import 'package:testt/model/price.dart';
import 'package:testt/model/term.dart';
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
  Future delAmber(int amberId);
  Future updateAmber(int amberId, String amberName);

  Future<(List<Masrofat>, int)> getMasrofat();
  Future addMasrof(int amount, String description);
  Future updateMasrof(int masrofId, int amount, String description);
  Future<Masrofat> showMasrof(int masrofId);
  Future delMasrof(int masrofId);
  Future<List<Masrofat>> searchMasrofat(String query);

  Future<List<Price>> getPrices();
  Future addPrice(String vegetableName, int smallShakara, int bigShakara, int ton);
  Future updatePrice(int id, String vegetableName, int smallShakara, int bigShakara, int ton);
  Future delPrice(Price price);
  Future<Price> showPrice(int id);

  Future<PersonalData> getPersonalData();
  Future updatePersonalData(String name, String phone, String password, String confirmPassword);

  Future<List<AllUsers>> getUsers();
  Future toggleActive(String userId);
  Future<List<AllUsers>> searchUser(String query);

  Future<List<Term>> getTerms();
  Future addTerm(String name, String start, String end);
  Future updateTerm(String termId, String name, String start, String end);
  Future<Term> showTerm(String termId);
  Future delTerm(String termId);
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
    List<Masrofat> masrofat = [];
    for (var singleMasrof in responseData["expense"]) {
      Masrofat masrof = Masrofat.fromJson(singleMasrof);
      masrofat.add(masrof);
    }
    return (masrofat, responseData["sum"] as int? ?? 0);
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

  @override
  Future<List<Masrofat>> searchMasrofat(String query) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}expense/search?keyword=$query";;;;;;;;;;;
    final response = await http.post(//////////////
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);
    List<Masrofat> masrofat = [];
    for (var singleMasrof in responseData["expense"]) {;;;;;;;;
      Masrofat masrof = Masrofat.fromJson(singleMasrof);
      masrofat.add(masrof);
    }
    return masrofat;
  }

  @override
  Future addPrice(String vegetableName, int smallShakara, int bigShakara, int ton) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}price?vegetable_name=$vegetableName&ton=$ton&small_shakara=$smallShakara&big_shakara=$bigShakara";
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
  Future delPrice(Price price) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}price/${price.id}/delete";
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
  Future<List<Price>> getPrices() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}price";
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
    List<Price> prices = [];
    for (var singlePrice in responseData["prices"]) {
      Price price = Price.fromJson(singlePrice);
      prices.add(price);
    }
    return prices;
  }

  @override
  Future<Price> showPrice(int id) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}price/$id/delete";
    final response = await http.delete(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);
    return Price.fromJson(responseData["price"]);
  }

  @override
  Future updatePrice(int id, String vegetableName, int smallShakara, int bigShakara, int ton) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}price/$id/edit?vegetable_name=$vegetableName&ton=$ton&small_shakara=$smallShakara&big_shakara=$bigShakara";
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
  Future<PersonalData> getPersonalData() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}user";
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
    return PersonalData.fromJson(responseData);
  }

  @override
  Future updatePersonalData(String name, String phone, String password, String confirmPassword) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/update?name=$name&phone=$phone&password=$password&password_confirmation=$confirmPassword";
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
  Future<List<AllUsers>> getUsers() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}users";
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
    List<AllUsers> users = [];
    for (var singleUser in responseData["user"]) {
      AllUsers user = AllUsers.fromJson(singleUser);
      users.add(user);
    }
    return users;
  }

  @override
  Future toggleActive(String userId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}active_user/$userId";
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
  Future<List<AllUsers>> searchUser(String query) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}user/search?keyword=$query";
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);
    List<AllUsers> users = [];
    for (var singleUser in responseData["users"]) {
      AllUsers user = AllUsers.fromJson(singleUser);
      users.add(user);
    }
    return users;
  }

  @override
  Future delAmber(int amberId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}amber/$amberId/delete";
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
  Future updateAmber(int amberId, String amberName) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}amber/$amberId/edit?name=$amberName";
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
  Future addTerm(String name, String start, String end) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}term?name=$name&start=$start&end=$end";
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
  Future delTerm(String termId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}term/$termId/delete";
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
  Future<List<Term>> getTerms() async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}term";
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
    List<Term> terms = [];
    for (var singleTerm in responseData["terms"]) {
      Term term = Term.fromJson(singleTerm);
      terms.add(term);
    }
    return terms;
  }

  @override
  Future<Term> showTerm(String termId) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}term/$termId/show";
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'charset': 'utf-8',
          "authorization" : "bearer $token"
        }
    );
    _checkServer(response);
    final responseData = await json.decode(response.body);
    return Term.fromJson(responseData["term"]);
  }

  @override
  Future updateTerm(String termId, String name, String start, String end) async {
    String token = await _appPreferences.getToken();
    await _checkNetwork();
    String url = "${Constants.baseUrl}term/$termId/edit?name=$name&start=$start&end=$end";
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