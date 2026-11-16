import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/network/auth_apiclient.dart';
import '../network/session_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio(SessionInterceptor sessionInterceptor) {
    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: ContentType.json.value,
      headers: {HttpHeaders.acceptHeader: ContentType.json.value},
    );

    final Dio dio = Dio(options);

    dio.interceptors.add(sessionInterceptor);

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
  AuthApiClient provideAuthApiClient(Dio dio) => AuthApiClient(dio);
}
