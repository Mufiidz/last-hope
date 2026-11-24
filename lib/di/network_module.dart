import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/network/auth_apiclient.dart';
import '../data/network/batch_apiclient.dart';
import '../data/network/endpoint.dart';
import '../data/network/story_apiclient.dart';
import '../network/env.dart';
import '../network/network_interceptor.dart';
import '../network/session_interceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  List<Interceptor> provideInterceptors(
    SessionInterceptor sessionInterceptor,
    NetworkInterceptor networkInterceptor,
  ) => [sessionInterceptor, networkInterceptor];

  @lazySingleton
  Dio provideDio(List<Interceptor> interceptors) {
    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: ContentType.json.value,
      headers: {HttpHeaders.acceptHeader: ContentType.json.value},
    );

    final Dio dio = Dio(options);

    dio.interceptors.addAll(interceptors);

    if (kReleaseMode) return dio;

    final PrettyDioLogger dioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    );

    dio.interceptors.add(dioLogger);

    return dio;
  }

  @singleton
  AuthApiClient provideAuthApiClient(Dio dio) =>
      AuthApiClient(dio, baseUrl: Endpoint.authUrl);

  @singleton
  StoryApiClient provideStoryApiClient(Dio dio) =>
      StoryApiClient(dio, baseUrl: Endpoint.storyUrl);

  @singleton
  BatchApiClient provideBatchApiClient(Dio dio) =>
      BatchApiClient(dio, baseUrl: Env.baseUrl);
}
