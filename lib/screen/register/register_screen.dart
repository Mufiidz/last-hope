import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

import '../../di/injection.dart';
import '../../model/request/register_request.dart';
import '../../utils/export_utils.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/widgets_export.dart';
import 'cubit/register_cubit.dart';
import 'register_field.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final RegisterCubit _cubit;
  late final LoadingDialog _loadingDialog;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<RegisterCubit>();
    _loadingDialog = getIt<LoadingDialog>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocEffect.listener(
        _cubit,
        sideEffect: (ctx, effect) => _handleEffect(context, effect),
        listenWhen: (previous, current) =>
            previous.statusState != current.statusState,
        listener: (BuildContext context, RegisterState state) {
          _loadingDialog.show(context, state.isLoading);
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
              autovalidateMode: AutovalidateMode.onUserInteractionIfError,
              children: [
                TextFieldWidget.focusBorder(
                  RegisterField.name,
                  context,
                  hint: 'Name',
                  filled: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                ),
                TextFieldWidget.focusBorder(
                  RegisterField.username,
                  context,
                  hint: 'Username',
                  filled: true,
                  textInputAction: TextInputAction.next,
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.username(
                      allowUnderscore: true,
                      allowDots: true,
                      allowSpecialChar: true,
                    ),
                    FormBuilderValidators.lowercase(),
                    FormBuilderValidators.match(
                      RegExp(r'^[a-z0-9]+[a-z0-9_]*(\.[a-z0-9]+[a-z0-9_]*)*$'),
                    ),
                  ],
                ),
                TextFieldWidget.focusBorder(
                  RegisterField.password,
                  context,
                  hint: 'Password',
                  filled: true,
                  obscureText: _hidePassword,
                  obscuringCharacter: '*',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  enableInteractiveSelection: false,
                  suffixIcon: IconButtonWidget(
                    iconData: _hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPressed: () => setState(() {
                      _hidePassword = !_hidePassword;
                    }),
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.hasUppercaseChars(),
                    FormBuilderValidators.hasLowercaseChars(),
                    FormBuilderValidators.hasNumericChars(),
                    FormBuilderValidators.hasSpecialChars(),
                    FormBuilderValidators.minLength(8),
                  ],
                ),
                TextFieldWidget.focusBorder(
                  RegisterField.passwordConfirm,
                  context,
                  hint: 'Confirm Password',
                  filled: true,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _hideConfirmPassword,
                  obscuringCharacter: '*',
                  enableInteractiveSelection: false,
                  suffixIcon: IconButtonWidget(
                    iconData: _hideConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPressed: () => setState(() {
                      _hideConfirmPassword = !_hideConfirmPassword;
                    }),
                  ),
                  onSubmitted: (value) => _onSubmit(),
                  validators: [
                    FormBuilderValidators.required(),
                    (val) {
                      final passwordValue =
                          _formKey
                                  .currentState
                                  ?.fields[RegisterField.password.key]
                                  ?.value
                              as String?;
                      if (val != passwordValue) {
                        return 'This field value must be equal to password';
                      }
                      return null;
                    },
                  ],
                ),
                Button.adaptive(
                  text: 'Register',
                  onPressed: _onSubmit,
                  width: context.mediaSize.width,
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Sign in.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.lightBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorField(Map<RegisterField, String> errors) {
    final formKeyState = _formKey.currentState;
    if (formKeyState == null) return;
    for (final error in errors.entries) {
      formKeyState.fields[error.key.name]?.invalidate(error.value);
    }
  }

  void _handleEffect(BuildContext context, RegisterEffect effect) =>
      switch (effect) {
        ShowFieldErrors(:final errors) => _showErrorField(errors),
        ShowSnackBar(:final message) => context.showSnackBar(
          SnackBarWidget.byState(
            context,
            message: message,
            state: SnackBarState.error,
          ),
        ),
        ShowErrorBottomSheet(:final data) => context.showErrorBottomSheet(
          data: data.copyWith(
            primaryButton: data.primaryButton.copyWith(
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
        ),
        NavigateToLogin() => () {
          _formKey.currentState?.reset();
          context.router.pop();
        },
      };

  void _onSubmit() {
    final formKeyState = _formKey.currentState;
    if (formKeyState == null || !formKeyState.saveAndValidate()) return;

    final param = RegisterRequestMapper.fromMap(formKeyState.value);
    AppLogger.debug(param, tag: 'FormRegis');

    _cubit.register(param);
  }

  @override
  void dispose() async {
    _formKey.currentState?.reset();
    _formKey.currentState?.dispose();
    await _cubit.close();
    super.dispose();
  }
}
