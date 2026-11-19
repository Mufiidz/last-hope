import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

import '../../utils/export_utils.dart';
import '../../widgets/widgets_export.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Ztories', style: context.textTheme.displayMedium),
            ),
          ),
          Expanded(
            child: FormWidget(
              _formKey,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                TextFieldWidget(
                  'username',
                  validators: [FormBuilderValidators.required()],
                ),
                TextFieldWidget(
                  'password',
                  obscureText: _hidePassword,
                  obscuringCharacter: '*',
                  suffixIcon: IconButton.filled(
                    onPressed: () => setState(() {
                      _hidePassword = !_hidePassword;
                    }),
                    icon: const Icon(Icons.visibility),
                  ),
                  validators: [FormBuilderValidators.required()],
                ),
                const Button(text: 'Login'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
