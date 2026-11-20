extension MapExt<K, V> on Map<K, V> {
  Map<K2, V2> mapNotNull<K2, V2>(
    MapEntry<K2, V2>? Function(K key, V value) transform,
  ) {
    final result = <K2, V2>{};
    forEach((key, value) {
      final mapped = transform(key, value);
      if (mapped != null) {
        result[mapped.key] = mapped.value;
      }
    });
    return result;
  }
}