abstract class BaseStorageKey {
  String get name;
}

enum GeneralStorageKey(@override final String name) implements BaseStorageKey {
  accessToken('accessToken'),
}

enum SharedPrefKey(@override final String name) implements BaseStorageKey {
  theme('theme'),
}
