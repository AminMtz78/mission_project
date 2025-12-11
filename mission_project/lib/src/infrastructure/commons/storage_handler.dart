import 'package:get_storage/get_storage.dart';

class StorageHandler {
  factory StorageHandler() => _instance;

  StorageHandler._();

  static final StorageHandler _instance = StorageHandler._();

  static final GetStorage _storage = GetStorage();

  Future<void> init() async {
    await _storage.initStorage;
  }

  static final String _isRememberUser = 'isRememberUser';
  static final String _locale = 'locale';

  static int get rememberedUserId => _storage.read(_isRememberUser) ?? 0;

  static String get locale => _storage.read(_locale) ?? 'en';

  static set setRememberedUserId(int value) {
    _storage.write(_isRememberUser, value);
  }

  static set setLocale(String language) => _storage.write(_locale, language);
}
