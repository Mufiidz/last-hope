import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

import '../../di/injection.dart';
import '../../model/request/login_request.dart';
import '../../utils/export_utils.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/widgets_export.dart';
import 'cubit/login_cubit.dart';
import 'login_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final LoginCubit _loginCubit;
  late final LoadingDialog _loadingDialog;
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _loginCubit = getIt<LoginCubit>();
    _loadingDialog = getIt<LoadingDialog>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocEffect.listener(
          _loginCubit,
          listenWhen: (previous, current) =>
              previous.statusState != current.statusState,
          listener: (context, state) {
            _loadingDialog.show(context, state.isLoading);
          },
          sideEffect: (ctx, effect) => switch (effect) {
            ShowFieldErrors(:final errors) => _showErrorField(errors),
            ShowSnackBar(:final message) => context.showSnackBar(
              SnackBarWidget.byState(
                context,
                message: message,
                state: SnackBarState.error,
              ),
            ),
            // TODO: Handle navigate to Home Route
            NavigateToHome() => (),
            ShowErrorBottomSheet(:final data) => context.showErrorBottomSheet(
              data: data.copyWith(
                primaryButton: data.primaryButton.copyWith(
                  onPressed: () {
                    context.router.pop();
                  },
                ),
              ),
            ),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 32,
            children: [
              Center(
                child: Text('Ztories', style: context.textTheme.displayMedium),
              ),
              FormWidget(
                _formKey,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: context.mediaSize.height * 0.05,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  TextFieldWidget.focusBorder(
                    LoginField.identity,
                    context,
                    hint: 'Username',
                    filled: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    validators: [FormBuilderValidators.required()],
                  ),
                  TextFieldWidget.focusBorder(
                    LoginField.password,
                    context,
                    hint: 'Password',
                    obscureText: _hidePassword,
                    obscuringCharacter: '*',
                    filled: true,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) => _onSubmit(),
                    suffixIcon: IconButtonWidget(
                      onPressed: () => setState(() {
                        _hidePassword = !_hidePassword;
                      }),
                      iconData: _hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    validators: [FormBuilderValidators.required()],
                  ),
                  Button.adaptive(
                    text: 'Login',
                    onPressed: _onSubmit,
                    width: context.mediaSize.width,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    final FormBuilderState? formKeyState = _formKey.currentState;
    if (formKeyState == null || !formKeyState.saveAndValidate()) return;

    final param = LoginRequestMapper.fromMap(formKeyState.value);

    _loginCubit.login(param);
  }

  void _showErrorField(Map<LoginField, String> errors) {
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    for (final error in errors.entries) {
      formKeyState.fields[error.key.name]?.invalidate(error.value);
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
