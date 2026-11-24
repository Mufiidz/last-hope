import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/request/batch_request.dart';

part 'batch_apiclient.g.dart';

@RestApi(parser: Parser.DartMappable)
abstract class BatchApiClient {
  factory BatchApiClient(Dio dio, {String baseUrl}) = _BatchApiClient;

  // TODO: wait for this PR https://github.com/trevorwang/retrofit.dart/pull/894
  // @POST('/batch')
  // Future<List<Map<String, dynamic>>> batch<T>(
  //   @Body(nullToAbsent: true) List<BatchRequest<T>> body,
  // );
}
