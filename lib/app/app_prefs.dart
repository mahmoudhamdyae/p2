import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String prefsKeyLang = "PREFS_KEY_LANG";
const String prefsKeyOnboardingScreenViewed =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyToken = "PREFS_KEY_TOKEN_IN";
const String prefsKeyIsActive = "PREFS_KEY_IS_ACTIVE";
const String prefsKeyIsAdmin = "PREFS_KEY_IS_ADMIN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    return LanguageType.arabic.getValue();
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      // Set English
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.english.getValue());
    } else {
      // Set Arabic
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }

  // Login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(prefsKeyToken, token);
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(prefsKeyToken) ?? "";
  }

  Future<void> setIsActive(bool isActive) async {
    _sharedPreferences.setBool(prefsKeyIsActive, isActive);
  }

  Future<bool> getIsActive() async {
    return _sharedPreferences.getBool(prefsKeyIsActive) ?? false;
  }

  Future<void> setIsAdmin(bool isAdmin) async {
    _sharedPreferences.setBool(prefsKeyIsAdmin, isAdmin);
  }

  Future<bool> getIsAdmin() async {
    return _sharedPreferences.getBool(prefsKeyIsAdmin) ?? false;
  }
}