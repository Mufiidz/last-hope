import 'package:material_ui/material_ui.dart';

import '../../model/story.dart';
import '../../utils/export_utils.dart';
import '../../widgets/widgets_export.dart';

class ItemStory extends StatelessWidget {
  final Story story;
  final VoidCallback? onClick;
  final VoidCallback? onActionMore;
  const ItemStory(this.story, {super.key, this.onClick, this.onActionMore});

  @override
  Widget build(BuildContext context) {
    const avatarSize = 42.0;
    return GestureDetector(
      onTap: onClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
                const Space.horizontal(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Text(
                            story.creator.username,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            story.createdAt.toRelativeTime(),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(story.content),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: onActionMore,
                  child: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          CaroselImages(
            story.attachments,
            margin: const EdgeInsetsGeometry.only(
              left: (avatarSize + 8 + 8),
              right: 32,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
