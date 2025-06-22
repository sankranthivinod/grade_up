

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class StorageUtil{
  const StorageUtil._();
  static final GetStorage _storage = GetStorage();


  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  static T? read<T>(String key) {
    _storage.read(key);
  }

  static Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  static Future<void> clear() async {
    await _storage.erase();
  }

  static bool containsKey(String key){
    return _storage.hasData(key);
  }
}