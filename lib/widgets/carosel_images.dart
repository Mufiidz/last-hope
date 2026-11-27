import 'package:material_ui/material_ui.dart';

import '../model/attachment.dart';
import 'widgets_export.dart';

class CaroselImages extends StatelessWidget {
  final List<Attachment> images;
  final EdgeInsetsGeometry margin;
  final double height;
  const CaroselImages(
    this.images, {
    super.key,
    this.margin = const EdgeInsets.only(left: 64, right: 32),
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return switch (images) {
      [] => const EmptyWidget(),
      [var attachment] => Padding(
        padding: margin,
        child: _image(attachment.content),
      ),
      _ => SizedBox(
        height: height,
        child: ListWidget.separated(
          images,
          scrollDirection: Axis.horizontal,
          padding: margin,
          itemBuilder: (context, item, index) => _image(item.content),
          separatorBuilder: (context, index) => const Space.horizontal(8),
        ),
      ),
    };
  }

  Widget _image(String url) => ConstrainedBox(
    constraints: BoxConstraints(maxHeight: height),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(url, fit: BoxFit.contain),
    ),
  );
}
