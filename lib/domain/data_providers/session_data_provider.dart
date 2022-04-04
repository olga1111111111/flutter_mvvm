import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_key';
}

class SessionDataProvider {
  // для хранения логина и пароля использовать securityStorage
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<String?> apiKey() async {
    return (await _sharedPreferences)
        .getString(SessionDataProviderKeys._apiKey);
  }

  // Future<void> saveApiKey(String? key) async {
  //   if (key != null) {
  //     (await _sharedPreferences).setString(SessionDataProviderKeys._apiKey, key);
  //   } else {
  //     (await _sharedPreferences).remove(SessionDataProviderKeys._apiKey);

  //   }
  // }
  Future<void> saveApiKey(String key) async {
    (await _sharedPreferences).setString(SessionDataProviderKeys._apiKey, key);
  }

  Future<void> clearApiKey() async {
    (await _sharedPreferences).remove(SessionDataProviderKeys._apiKey);
  }
}
