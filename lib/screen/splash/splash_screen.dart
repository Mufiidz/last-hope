import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

import '../../di/injection.dart';
import '../../utils/export_utils.dart';
import '../../widgets/bloc_effect.dart';
import 'cubit/splash_screen_cubit.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocEffect<SplashScreenState, SplashScreenEffect>(
        getIt<SplashScreenCubit>(),
        sideEffect: (context, effect) => switch (effect) {
          NavigateScreen(:final route) => context.router.replace(
            NamedRoute(route),
          ),
        },
        child: SizedBox(
          width: context.mediaSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Text('Ztories', style: context.textTheme.displayMedium),
              const CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }
}
