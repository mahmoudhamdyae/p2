import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testt/data/services/account_service.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/presentation/main/fridges/fridges_controller.dart';
import 'package:testt/presentation/main/masrofat/masrofat_controller.dart';

import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // App module, its a module where we put all generic dependencies

  // Shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // AccountService
  instance.registerLazySingleton<AccountService>(
          () => AccountServiceImpl(instance<NetworkInfo>(), instance<AppPreferences>()));

  // Api Service
  instance.registerLazySingleton<ApiService>(
          () => ApiServiceImpl(instance<NetworkInfo>(), instance<AppPreferences>()));

  // Fridges Controller
  instance.registerLazySingleton<FridgesController>(
      () => Get.put(FridgesController(instance<ApiService>())));

  // Masrofat Controller
  instance.registerLazySingleton<MasrofatController>(
          () => Get.put(MasrofatController(instance<ApiService>())));
}