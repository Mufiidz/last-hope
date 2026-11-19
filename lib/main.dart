import 'package:flutter/foundation.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

import 'di/injection.dart';
import 'routes/app_router.dart';
import 'utils/context_ext.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: getIt<AppRouter>().config(),
      debugShowCheckedModeBanner: kDebugMode,
      theme: context.materialTheme.light(),
      darkTheme: context.materialTheme.darkHighContrast(),
      localizationsDelegates: [FormBuilderLocalizations.delegate],
    );
  }
}
