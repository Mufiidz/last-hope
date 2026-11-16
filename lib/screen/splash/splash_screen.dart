import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../di/injection.dart';
import '../../utils/export_utils.dart';
import 'cubit/splash_screen_cubit.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        bloc: getIt<SplashScreenCubit>(),
        listenWhen: (previous, current) => current.isAuthenticated != null,
        listener: (context, state) {
          // if (state.isAuthenticated == true) {
          //   context.replaceRoute(const LoginRoute());
          // } else {
          //   context.replaceRoute(const LoginRoute());
          // }
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
