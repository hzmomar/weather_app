import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teleport_air_asia/core/constant/string_constant.dart';
import 'package:teleport_air_asia/core/model/city_model.dart';

abstract class PreferencesService {
  Future<bool> clearSession();

  Future<String?> getString({required String key});

  Future<bool> setString({required String key, required String value});

  Future<void> savedSelectedCities({required List<City> cities});

  Future<List<City>> getSelectedCities();
}

class PreferencesServiceImpl implements PreferencesService {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  static const settingsLanguageLocale = 'settings_language_locale';
  static const profileKey = 'profileKey';
  static const _selectedCitiesKey = 'selectedCitiesKey';

  @override
  Future<bool> setString({required String key, required String value}) async {
    final SharedPreferences pref = await prefs;
    return await pref.setString(key, value);
  }

  @override
  Future<String?> getString({required String key}) async {
    final SharedPreferences pref = await prefs;
    return pref.getString(key);
  }

  /// Clear Session
  @override
  Future<bool> clearSession() async {
    final SharedPreferences pref = await prefs;
    final String languageLocale = pref.getString(ConstantString.languageKey)!;
    final bool result = await pref.clear();
    await pref.setString(ConstantString.languageKey, languageLocale);
    return result;
  }

  @override
  Future<void> savedSelectedCities({required List<City> cities}) async {
    final List<Map<String, dynamic>> _json =
        cities.map((e) => e.toJson()).toList();
    await setString(
      key: _selectedCitiesKey,
      value: json.encode({_selectedCitiesKey: _json}),
    );
  }

  @override
  Future<List<City>> getSelectedCities() async {
    final String? _selectedCities = await getString(key: _selectedCitiesKey);
    if (_selectedCities != null) {
      final Map<String, dynamic> _json = json.decode(_selectedCities);
      return (_json[_selectedCitiesKey] as List)
          .map((e) => City.fromPreferenceJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
