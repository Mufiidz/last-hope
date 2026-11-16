import 'package:material_ui/material_ui.dart';

enum SpaceSize {
  /// Size 8.0
  small(8.0),
  /// Size 16.0
  medium(16.0),
  /// Size 24.0
  large(24.0),
  
  extraLarge(32.0);

  final double value;

  const SpaceSize(this.value);
}

class Space extends StatelessWidget {
  final Object? sizeHeight;
  final Object? sizeWidth;

  const Space({super.key, Object? height, Object? width})
    : sizeHeight = height,
      sizeWidth = width;

  const Space.vertical(Object size, {super.key})
    : sizeHeight = size,
      sizeWidth = null;

  const Space.horizontal(Object size, {super.key})
    : sizeWidth = size,
      sizeHeight = null;

  @override
  Widget build(BuildContext context) {
    final height = getSize(sizeHeight);
    final width = getSize(sizeWidth);
    return SizedBox(height: height, width: width);
  }

  double? getSize(Object? size) => switch (size) {
    null => null,
    SpaceSize s => s.value,
    double d => d,
    int i => i.toDouble(),
    String s => double.tryParse(s),
    _ => throw ArgumentError(
      'Invalid size type. Use double, int, or SpaceSize.',
    ),
  };
}
