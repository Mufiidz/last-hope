import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/request/story_request.dart';
import '../../model/response/paging_response.dart';
import '../../model/response/story_response.dart';
import 'query_param_key.dart';

part 'story_apiclient.g.dart';

@RestApi(parser: Parser.DartMappable)
abstract class StoryApiClient {
  factory StoryApiClient(Dio dio, {String baseUrl}) = _StoryApiClient;

  @POST('/records')
  Future<StoryResponse> create(
    @Body(nullToAbsent: true) StoryRequest body, {
    @Query(QueryParamKey.expand) String? expand,
    @Query(QueryParamKey.field) String? field,
  });

  @GET('/records')
  Future<PagingResponse<StoryResponse>> getItems({
    @Query(QueryParamKey.page) int? page,
    @Query(QueryParamKey.perPage) int? perPage,
    @Query(QueryParamKey.sort) String? sort,
    @Query(QueryParamKey.filter) String? filter,
    @Query(QueryParamKey.expand) String? expand,
    @Query(QueryParamKey.field) String? field,
  });

  @GET('/records/{id}')
  Future<StoryResponse> getItem(
    @Path('id') String id, {
    @Query(QueryParamKey.expand) String? expand,
    @Query(QueryParamKey.field) String? field,
  });

  @PATCH('records/{id}')
  Future<StoryResponse> update(
    @Path('id') String id,
    @Body() StoryRequest body, {
    @Query(QueryParamKey.expand) String? expand,
    @Query(QueryParamKey.field) String? field,
  });

  @DELETE('records/{id}')
  Future<void> delete(
    @Path('id') String id, {
    @Query(QueryParamKey.expand) String? expand,
    @Query(QueryParamKey.field) String? field,
  });
}
