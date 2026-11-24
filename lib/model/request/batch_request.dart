import 'package:dart_mappable/dart_mappable.dart';

part 'batch_request.mapper.dart';

@MappableClass()
class BatchRequest<T> with BatchRequestMappable {
  final BatchRequestMethod method;
  final String url;
  final T body;

  new({required this.method, required this.url, required this.body});

  const BatchRequest.post({required this.url, required this.body})
    : method = BatchRequestMethod.post;

  const BatchRequest.get({required this.url, required this.body})
    : method = BatchRequestMethod.get;

  const BatchRequest.patch({required this.url, required this.body})
    : method = BatchRequestMethod.patch;

  const BatchRequest.delete({required this.url, required this.body})
    : method = BatchRequestMethod.delete;
}

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum BatchRequestMethod { post, get, patch, delete }
