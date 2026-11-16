// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'splash_screen_cubit.dart';

class SplashScreenStateMapper extends ClassMapperBase<SplashScreenState> {
  SplashScreenStateMapper._();

  static SplashScreenStateMapper? _instance;
  static SplashScreenStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SplashScreenStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SplashScreenState';

  static bool _$isLoading(SplashScreenState v) => v.isLoading;
  static const Field<SplashScreenState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: true,
  );
  static bool? _$isAuthenticated(SplashScreenState v) => v.isAuthenticated;
  static const Field<SplashScreenState, bool> _f$isAuthenticated = Field(
    'isAuthenticated',
    _$isAuthenticated,
    opt: true,
  );

  @override
  final MappableFields<SplashScreenState> fields = const {
    #isLoading: _f$isLoading,
    #isAuthenticated: _f$isAuthenticated,
  };

  static SplashScreenState _instantiate(DecodingData data) {
    return SplashScreenState(
      isLoading: data.dec(_f$isLoading),
      isAuthenticated: data.dec(_f$isAuthenticated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SplashScreenState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SplashScreenState>(map);
  }

  static SplashScreenState fromJson(String json) {
    return ensureInitialized().decodeJson<SplashScreenState>(json);
  }
}

mixin SplashScreenStateMappable {
  String toJson() {
    return SplashScreenStateMapper.ensureInitialized()
        .encodeJson<SplashScreenState>(this as SplashScreenState);
  }

  Map<String, dynamic> toMap() {
    return SplashScreenStateMapper.ensureInitialized()
        .encodeMap<SplashScreenState>(this as SplashScreenState);
  }

  SplashScreenStateCopyWith<
    SplashScreenState,
    SplashScreenState,
    SplashScreenState
  >
  get copyWith =>
      _SplashScreenStateCopyWithImpl<SplashScreenState, SplashScreenState>(
        this as SplashScreenState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SplashScreenStateMapper.ensureInitialized().stringifyValue(
      this as SplashScreenState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SplashScreenStateMapper.ensureInitialized().equalsValue(
      this as SplashScreenState,
      other,
    );
  }

  @override
  int get hashCode {
    return SplashScreenStateMapper.ensureInitialized().hashValue(
      this as SplashScreenState,
    );
  }
}

extension SplashScreenStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SplashScreenState, $Out> {
  SplashScreenStateCopyWith<$R, SplashScreenState, $Out>
  get $asSplashScreenState => $base.as(
    (v, t, t2) => _SplashScreenStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SplashScreenStateCopyWith<
  $R,
  $In extends SplashScreenState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isLoading, bool? isAuthenticated});
  SplashScreenStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SplashScreenStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SplashScreenState, $Out>
    implements SplashScreenStateCopyWith<$R, SplashScreenState, $Out> {
  _SplashScreenStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SplashScreenState> $mapper =
      SplashScreenStateMapper.ensureInitialized();
  @override
  $R call({bool? isLoading, Object? isAuthenticated = $none}) => $apply(
    FieldCopyWithData({
      if (isLoading != null) #isLoading: isLoading,
      if (isAuthenticated != $none) #isAuthenticated: isAuthenticated,
    }),
  );
  @override
  SplashScreenState $make(CopyWithData data) => SplashScreenState(
    isLoading: data.get(#isLoading, or: $value.isLoading),
    isAuthenticated: data.get(#isAuthenticated, or: $value.isAuthenticated),
  );

  @override
  SplashScreenStateCopyWith<$R2, SplashScreenState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SplashScreenStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

