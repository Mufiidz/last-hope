import '../data/storage/key_storage.dart';

abstract class BaseStorage {
  Future<void> setString(BaseStorageKey key, String value);
  Future<String?> getString(BaseStorageKey key);
  Future<void> remove(BaseStorageKey key);
  Future<void> clear();
}
