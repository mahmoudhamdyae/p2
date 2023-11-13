import 'package:get/get.dart';
import 'package:testt/model/price.dart';
import 'package:uuid/uuid.dart';

import '../../../data/services/api_service.dart';

class PricesController extends GetxController {
  final ApiService _apiService;
  RxList<Price> prices = List<Price>.empty().obs;
  Rx<Price> price = Price("", -1, -1, -1, -1, -1).obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  PricesController(this._apiService);

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

  Future addPrice(String vegetableName, int smallShakara, int bigShakara, int ton) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addPrice(vegetableName, smallShakara, bigShakara, ton).then((value) {
        prices.value.add(Price("", -1, -1, -1, -1, int.parse(const Uuid().v4.toString())));
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

  Future updatePrice(Price price) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.updatePrice(price).then((value) {
        prices.value = prices.value.map((newPrice) {
          if (newPrice.id == price.id) {
            return Price(price.vegetableName, price.ton, price.small_shakara, price.big_shakara, price.user_id, price.id);
          } else {
            return newPrice;
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

  Future showPrice(int priceId) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.showPrice(priceId).then((value) {
        price.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  Future delPrice(Price price) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.delPrice(price).then((value) {
        prices.value.remove(value);
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}