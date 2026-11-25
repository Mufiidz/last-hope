class Env {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String storageUrl = String.fromEnvironment('STORAGE_URL');
}