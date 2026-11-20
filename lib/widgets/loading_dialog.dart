import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';

import '../utils/context_ext.dart';

@singleton
class LoadingDialog {
  bool _isShown = false;
  bool get isShown => _isShown;
  BuildContext? _dialogContext;

  void show(BuildContext context, bool isLoading, {bool dismissable = false}) {
    if (isLoading) {
      _showLoading(context, dismissable: dismissable);
    } else {
      _dismiss();
    }
  }

  void _showLoading(BuildContext context, {bool dismissable = false}) {
    if (_isShown || !context.mounted) return;
    _dialogContext = context;
    _isShown = true;
    showDialog<void>(
      context: context,
      barrierDismissible: dismissable,
      builder: (dialogContext) {
        return PopScope(
          canPop: dismissable,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: dialogContext.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: const CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    ).whenComplete(() {
      // Dipanggil saat dialog tertutup dengan cara apa pun
      // (dismiss(), barrier tap, tombol back).
      _isShown = false;
      _dialogContext = null;
    });
  }

  void _dismiss() {
    final context = _dialogContext;
    _isShown = false;

    if (context != null) {
      context.router.pop();
    }

    _dialogContext = null;
  }
}
