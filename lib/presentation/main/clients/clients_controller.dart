import 'package:get/get.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/model/amber.dart';
import 'package:uuid/uuid.dart';

import '../../../model/fridge.dart';
import '../../../model/price.dart';
import '../../../model/term.dart';

class ClientsController extends GetxController {
  final ApiService _apiService;

  ClientsController(this._apiService);

  RxList<Fridge> fridges = List<Fridge>.empty().obs;
  Rx<Fridge> fridge = Fridge(0, "", "", -1, Owner(""), []).obs;
  Rx<Amber> amber = Amber(-1, "", "", -1, Owner("")).obs;

  RxList<Term> terms = List<Term>.empty().obs;
  Rx<Term> term = Term(-1, "", "", "", -1).obs;

  RxList<Price> prices = List<Price>.empty().obs;
  Rx<Price> price = Price("", "-1", "-1", "-1", -1, -1).obs;

  Rx<String> status = "person".obs;

  Rx<int> wayNumber = 0.obs;
  Rx<int> fixedPrice = 0.obs;
  Rx<int> ton = 0.obs;
  Rx<int> smallShakara = 0.obs;
  Rx<int> bigShakara = 0.obs;

  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  Future getFridges() async {
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

  Future getTerms() async {
    try {
      isLoading.value = true;
      terms.value = List<Term>.empty();
      error.value = '';
      await _apiService.getTerms().then((value) {
        terms.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future getPrices() async {
    try {
      isLoading.value = true;
      prices.value = List<Price>.empty();
      error.value = '';
      await _apiService.getPrices().then((value) {
        prices.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      prices.value = List<Price>.empty();
      isLoading.value = false;
    }
  }

  setFridge(Fridge newFridge) {
    fridge.value = newFridge;
  }

  setAmber(Amber newAmber) {
    amber.value = newAmber;
  }

  setTerm(Term newTerm) {
    term.value = newTerm;
  }

  setPrice(Price newPrice) {
    price.value = newPrice;
  }

  setStatus(String newStatus) {
    status.value = newStatus;
  }

  Future addClient(String name, String phone, String address) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addClient(
          amber.value.id.toString(),
          fridge.value.id.toString(),
          price.value.id.toString(),
          term.value.id.toString(),
          name,
          phone,
          address,
          status.value,
          wayNumber.value,
          fixedPrice.value,
          ton.value.toString(),
          smallShakara.value.toString(),
          bigShakara.value.toString()
      ).then((value) {
        error.value = '';
        isLoading.value = false;
        clearAll();
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  clearAll() {
    fridges = List<Fridge>.empty().obs;
    fridge = Fridge(0, "", "", -1, Owner(""), []).obs;
    amber = Amber(-1, "", "", -1, Owner("")).obs;

    terms = List<Term>.empty().obs;
    term = Term(-1, "", "", "", -1).obs;

    prices = List<Price>.empty().obs;
    price = Price("", "-1", "-1", "-1", -1, -1).obs;

    status = "person".obs;

    wayNumber = 0.obs;
    fixedPrice = 0.obs;
    ton = 0.obs;
    smallShakara = 0.obs;
    bigShakara = 0.obs;
  }

  setFirstWay(String price) {
    wayNumber.value = 1;
    fixedPrice.value = int.parse(price);
  }

  setSecondWay(String newTon, String newSmallShakara, String newBigShakara) {
    wayNumber.value = 2;
    if (newTon == "") newTon = "0";
    if (newSmallShakara == "") newSmallShakara = "0";
    if (newBigShakara == "") newBigShakara = "0";
    ton.value = int.parse(newTon);
    smallShakara.value = int.parse(newSmallShakara);
    bigShakara.value = int.parse(newBigShakara);
  }

  setThirdWay(String price) {
    wayNumber.value = 3;
    fixedPrice.value = int.parse(price);
  }

  Future<void> addTerm(String name, String start, String end) async {
    if (terms.value.any((element) => element.name == name)) {
      throw Exception("هذا الاسم مستخدم من قبل");
    }
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addTerm(name, start, end).then((value) {
        terms.value.add(Term(-1, name, start, end, -1));
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future addPrice(String vegetableName, int smallShakara, int bigShakara, int ton) async {
    if (prices.value.any((element) => element.vegetableName == vegetableName)) {
      throw Exception("هذا الاسم مستخدم من قبل");
    }
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addPrice(vegetableName, smallShakara, bigShakara, ton).then((value) {
        prices.value.add(Price("", "-1", "-1", "-1", -1, int.parse(const Uuid().v4.toString())));
        error.value = '';
        isLoading.value = false;
        getPrices();
      });
    } on Exception catch (e) {
      // error.value = e.toString();
      isLoading.value = false;
      getPrices();
    }
  }
}