import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:teleport_air_asia/core/constant/asset_constant.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/service/sharedpreference/sharedpreference_service.dart';

class LocalizationService {
  static final LocalizationService _translations =
  LocalizationService._internal();

  factory LocalizationService() {
    return _translations;
  }

  LocalizationService._internal();

  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;
  VoidCallback? _onLocaleChangedCallback;
  final PreferencesService _preferencesService = locator<PreferencesService>();
  static const List<String> supportedLanguages = [
    'English',
  ];
  static const List<String> supportedLanguagesCodes = [
    'en',
  ];

  String get currentLanguage => _locale == null ? '' : _locale!.languageCode;

  Locale get locale => _locale!;

  set onLocaleChangedCallback(VoidCallback callback) {
    _onLocaleChangedCallback = callback;
  }

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((lang) => Locale(lang, ''));

  String text(String key) {
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  Future<Null> init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  Future<String?> getPreferredLanguage() async {
    return getApplicationSavedInformation('${ConstantString.language}');
  }

  Future<bool> setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('${ConstantString.language}', lang);
  }

  Future<Null> setNewLanguage(
      [String? newLanguage, bool saveInPrefs = true]) async {
    String? language = newLanguage;
    language ??= await getPreferredLanguage();
    language ??= supportedLanguagesCodes.first;
    _locale = Locale(language, '');
    final String jsonContent = await rootBundle
        .loadString('${ConstantAsset.localizationPath}${locale.languageCode}${ConstantString.localizationFormat}');

    _localizedValues = json.decode(jsonContent);

    if (saveInPrefs) {
      await setPreferredLanguage(language);
    }
    _onLocaleChangedCallback?.call();

    return null;
  }

  Future<String?> getApplicationSavedInformation(String name) async {
    return await _preferencesService.getString(key: '${ConstantString.storageKey}$name');
  }

  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    return _preferencesService.setString(
        key: '${ConstantString.storageKey}$name', value: value);
  }
}

LocalizationService localizationService = LocalizationService();
