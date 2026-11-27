import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../base/base_state.dart';
import '../../di/injection.dart';
import '../../utils/export_utils.dart';
import '../../widgets/widgets_export.dart';
import 'cubit/home_cubit.dart';
import 'item_story.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<HomeCubit>();
    _cubit.getStories();
  }

  @override
  Widget build(BuildContext context) {
    final topOffset = context.mediaQueryPadding.top + kToolbarHeight + 2;
    return Scaffold(
      appBar: const AppBarWidget(title: 'Ztories'),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: context.mediaSize.width,
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.isLoadingScreen) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            final errorMessage = switch (state.statusStateScreen) {
              StatusStateScreen.failure when state.stories.isEmpty =>
                state.message.orDefault('Failed to load stories.'),
              _ => 'Nothing stories here.',
            };
            return RefreshIndicator.adaptive(
              edgeOffset: topOffset,
              strokeWidth: 3,
              onRefresh: () async => _cubit.getStories(),
              child: switch (state.statusStateScreen) {
                _ when state.stories.isNotEmpty => ListWidget.separated(
                  state.stories,
                  padding: EdgeInsets.only(bottom: 16, top: topOffset),
                  itemBuilder: (context, item, index) => ItemStory(item),
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey.shade200),
                ),
                _ => LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                      ),
                      child: Center(child: Text(errorMessage)),
                    ),
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}
