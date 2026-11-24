import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../base/base_cubit.dart';
import '../base/base_effect.dart';
import '../base/base_state.dart';

typedef SideEffectWidgetListener<E extends BaseEffect> = void Function(
  // TODO: Disable this context
  BuildContext context,
  E effect,
);

class BlocEffect<S extends BaseState, E extends BaseEffect>
    extends StatefulWidget {
  final BaseCubit<S, E> bloc;
  final BlocWidgetBuilder<S>? builder;
  final BlocWidgetListener<S>? listener;
  final SideEffectWidgetListener<E>? sideEffect;
  final BlocBuilderCondition<S>? buildWhen;
  final BlocListenerCondition<S>? listenWhen;
  final Widget? child;

  const BlocEffect(
    this.bloc, {
    super.key,
    required SideEffectWidgetListener<E> this.sideEffect,
    this.child,
  }) : builder = null,
       listener = null,
       buildWhen = null,
       listenWhen = null;

  const BlocEffect.all(
    this.bloc, {
    super.key,
    this.builder,
    this.listener,
    this.sideEffect,
    this.buildWhen,
    this.listenWhen,
    this.child,
  }) : assert(
         builder != null || child != null,
         'Either builder or child must be provided.',
       );

  const BlocEffect.builder(
    this.bloc, {
    super.key,
    required BlocWidgetBuilder<S> this.builder,
    this.buildWhen,
    this.sideEffect,
  }) : listener = null,
       listenWhen = null,
       child = null;

  const BlocEffect.listener(
    this.bloc, {
    super.key,
    required BlocWidgetListener<S> this.listener,
    required Widget this.child,
    this.listenWhen,
    this.sideEffect,
  }) : builder = null,
       buildWhen = null;

  const BlocEffect.child(
    this.bloc, {
    super.key,
    required Widget this.child,
    required SideEffectWidgetListener<E> this.sideEffect,
  }) : builder = null,
       listener = null,
       buildWhen = null,
       listenWhen = null;

  @override
  State<BlocEffect<S, E>> createState() => _BlocEffectState<S, E>();
}

class _BlocEffectState<S extends BaseState, E extends BaseEffect>
    extends State<BlocEffect<S, E>> {
  StreamSubscription<E>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant BlocEffect<S, E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc != widget.bloc) {
      _unsubscribe();
      _subscribe();
    }
  }

  void _subscribe() {
    _effectSubscription = widget.bloc.sideEffect.listen((effect) {
      if (!mounted) return;
      // Baca callback terbaru saat event datang, bukan yang ditangkap di initState.
      widget.sideEffect?.call(context, effect);
    });
  }

  void _unsubscribe() {
    _effectSubscription?.cancel();
    _effectSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget current = widget.child ?? const SizedBox.shrink();

    final builder = widget.builder;
    if (builder != null) {
      current = BlocBuilder<BaseCubit<S, E>, S>(
        bloc: widget.bloc,
        buildWhen: widget.buildWhen,
        builder: builder,
      );
    }

    final listener = widget.listener;
    if (listener != null) {
      current = BlocListener<BaseCubit<S, E>, S>(
        bloc: widget.bloc,
        listenWhen: widget.listenWhen,
        listener: listener,
        child: current,
      );
    }

    return current;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}
