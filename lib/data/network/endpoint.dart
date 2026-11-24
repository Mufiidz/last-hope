import '../../network/env.dart';

class Endpoint {
  /// Auth API Endpoint
  static const String authUrl = '${Env.baseUrl}/collections/users';

  /// Story API Endpoint
  static const String storyUrl = '${Env.baseUrl}/collections/stories';
}
