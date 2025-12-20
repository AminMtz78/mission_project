import 'package:get_storage/get_storage.dart';

class StorageHandler {
  factory StorageHandler() => _instance;

  StorageHandler._();

  static final StorageHandler _instance = StorageHandler._();

  static final GetStorage _storage = GetStorage();

  Future<void> init() async {
    await GetStorage.init();
    await _storage.initStorage;
  }

  static final String _isRememberUser = 'isRememberUser';
  static final String _locale = 'locale';

  int? getUserId() => _storage.read(_isRememberUser);

  String getLocale() => _storage.read(_locale);

  void setRememberedUserId(int? value) async {
    await _storage.write(_isRememberUser, value);
  }

  void setLocale(String language) async =>
      await _storage.write(_locale, language);
}
