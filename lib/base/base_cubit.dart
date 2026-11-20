import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_effect.dart';
import 'base_state.dart';

abstract class BaseCubit<S extends BaseState, E extends BaseEffect>
    extends Cubit<S> {
  BaseCubit(super.initialState);

  final StreamController<E> _effectController = StreamController<E>.broadcast();

  Stream<E> get sideEffect => _effectController.stream;

  @protected
  void emitEffect(E effect) {
    if (isClosed || _effectController.isClosed) return;
    _effectController.add(effect);
  }

  @override
  Future<void> close() async {
    await _effectController.close();
    return super.close();
  }
}
