import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';

part 'paging_response.mapper.dart';

@MappableClass()
class PagingResponse<T> with PagingResponseMappable<T> {
  final int page;
  final int perPage;
  final int totalItems;
  final int totalPages;
  final List<T> items;

  PagingResponse({
    this.page = kZeroInt,
    this.perPage = kZeroInt,
    this.totalItems = kZeroInt,
    this.totalPages = kZeroInt,
    this.items = const [],
  });
}
