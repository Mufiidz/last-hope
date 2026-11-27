import 'package:material_ui/material_ui.dart';

typedef OnItemBuilder<Item> = Widget Function(
  BuildContext context,
  Item item,
  int index,
);

class ListWidget<T> extends ListView {
  final List<T> items;
  final OnItemBuilder<T> itemBuilder;

  ListWidget(
    this.items, {
    required this.itemBuilder,
    super.key,
    int? length,
    super.padding,
    super.controller,
    super.shrinkWrap,
    super.scrollDirection,
    ScrollPhysics? scrollPhysics,
  }) : super.builder(
         itemBuilder: (context, index) =>
             itemBuilder(context, items[index], index),
         itemCount: length ?? items.length,
         physics:
             scrollPhysics ??
             const AlwaysScrollableScrollPhysics(
               parent: BouncingScrollPhysics(),
             ),
       );

  ListWidget.horizontal(
    this.items, {
    required this.itemBuilder,
    super.key,
    int? length,
    super.padding,
    super.controller,
    super.shrinkWrap,
    ScrollPhysics? scrollPhysics,
  }) : super.builder(
         itemBuilder: (context, index) =>
             itemBuilder(context, items[index], index),
         itemCount: length ?? items.length,
         physics:
             scrollPhysics ??
             const AlwaysScrollableScrollPhysics(
               parent: BouncingScrollPhysics(),
             ),
         scrollDirection: Axis.horizontal,
       );

  ListWidget.separated(
    this.items, {
    required this.itemBuilder,
    required super.separatorBuilder,
    super.key,
    int? length,
    super.padding,
    super.controller,
    super.shrinkWrap,
    super.scrollDirection,
    ScrollPhysics? scrollPhysics,
  }) : super.separated(
         itemBuilder: (context, index) =>
             itemBuilder(context, items[index], index),
         itemCount: length ?? items.length,
         physics:
             scrollPhysics ??
             const AlwaysScrollableScrollPhysics(
               parent: BouncingScrollPhysics(),
             ),
       );
}
