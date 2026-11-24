import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../base/base_state.dart';
import '../../di/injection.dart';
import '../../utils/export_utils.dart';
import '../../widgets/widgets_export.dart';
import 'cubit/home_cubit.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SizedBox(
        width: context.mediaSize.width,
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (context, state) => switch (state.statusStateScreen) {
            StatusStateScreen.loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            StatusStateScreen.failure => Center(
              child: Text(state.message.orEmpty()),
            ),
            _ => Container(),
          },
        ),
      ),
    );
  }
}
