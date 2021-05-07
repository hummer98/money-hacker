// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'furusato_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FurusatoPageState _$FurusatoPageStateFromJson(Map<String, dynamic> json) {
  return _FurusatoPageState.fromJson(json);
}

/// @nodoc
class _$FurusatoPageStateTearOff {
  const _$FurusatoPageStateTearOff();

  _FurusatoPageState call(
      {int incomeTaxRate = 0, dynamic residentTaxAmount = 0}) {
    return _FurusatoPageState(
      incomeTaxRate: incomeTaxRate,
      residentTaxAmount: residentTaxAmount,
    );
  }

  FurusatoPageState fromJson(Map<String, Object> json) {
    return FurusatoPageState.fromJson(json);
  }
}

/// @nodoc
const $FurusatoPageState = _$FurusatoPageStateTearOff();

/// @nodoc
mixin _$FurusatoPageState {
  int get incomeTaxRate => throw _privateConstructorUsedError;
  dynamic get residentTaxAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FurusatoPageStateCopyWith<FurusatoPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FurusatoPageStateCopyWith<$Res> {
  factory $FurusatoPageStateCopyWith(
          FurusatoPageState value, $Res Function(FurusatoPageState) then) =
      _$FurusatoPageStateCopyWithImpl<$Res>;
  $Res call({int incomeTaxRate, dynamic residentTaxAmount});
}

/// @nodoc
class _$FurusatoPageStateCopyWithImpl<$Res>
    implements $FurusatoPageStateCopyWith<$Res> {
  _$FurusatoPageStateCopyWithImpl(this._value, this._then);

  final FurusatoPageState _value;
  // ignore: unused_field
  final $Res Function(FurusatoPageState) _then;

  @override
  $Res call({
    Object? incomeTaxRate = freezed,
    Object? residentTaxAmount = freezed,
  }) {
    return _then(_value.copyWith(
      incomeTaxRate: incomeTaxRate == freezed
          ? _value.incomeTaxRate
          : incomeTaxRate // ignore: cast_nullable_to_non_nullable
              as int,
      residentTaxAmount: residentTaxAmount == freezed
          ? _value.residentTaxAmount
          : residentTaxAmount // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$FurusatoPageStateCopyWith<$Res>
    implements $FurusatoPageStateCopyWith<$Res> {
  factory _$FurusatoPageStateCopyWith(
          _FurusatoPageState value, $Res Function(_FurusatoPageState) then) =
      __$FurusatoPageStateCopyWithImpl<$Res>;
  @override
  $Res call({int incomeTaxRate, dynamic residentTaxAmount});
}

/// @nodoc
class __$FurusatoPageStateCopyWithImpl<$Res>
    extends _$FurusatoPageStateCopyWithImpl<$Res>
    implements _$FurusatoPageStateCopyWith<$Res> {
  __$FurusatoPageStateCopyWithImpl(
      _FurusatoPageState _value, $Res Function(_FurusatoPageState) _then)
      : super(_value, (v) => _then(v as _FurusatoPageState));

  @override
  _FurusatoPageState get _value => super._value as _FurusatoPageState;

  @override
  $Res call({
    Object? incomeTaxRate = freezed,
    Object? residentTaxAmount = freezed,
  }) {
    return _then(_FurusatoPageState(
      incomeTaxRate: incomeTaxRate == freezed
          ? _value.incomeTaxRate
          : incomeTaxRate // ignore: cast_nullable_to_non_nullable
              as int,
      residentTaxAmount: residentTaxAmount == freezed
          ? _value.residentTaxAmount
          : residentTaxAmount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FurusatoPageState
    with DiagnosticableTreeMixin
    implements _FurusatoPageState {
  const _$_FurusatoPageState(
      {this.incomeTaxRate = 0, this.residentTaxAmount = 0});

  factory _$_FurusatoPageState.fromJson(Map<String, dynamic> json) =>
      _$_$_FurusatoPageStateFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int incomeTaxRate;
  @JsonKey(defaultValue: 0)
  @override
  final dynamic residentTaxAmount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FurusatoPageState(incomeTaxRate: $incomeTaxRate, residentTaxAmount: $residentTaxAmount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FurusatoPageState'))
      ..add(DiagnosticsProperty('incomeTaxRate', incomeTaxRate))
      ..add(DiagnosticsProperty('residentTaxAmount', residentTaxAmount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FurusatoPageState &&
            (identical(other.incomeTaxRate, incomeTaxRate) ||
                const DeepCollectionEquality()
                    .equals(other.incomeTaxRate, incomeTaxRate)) &&
            (identical(other.residentTaxAmount, residentTaxAmount) ||
                const DeepCollectionEquality()
                    .equals(other.residentTaxAmount, residentTaxAmount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(incomeTaxRate) ^
      const DeepCollectionEquality().hash(residentTaxAmount);

  @JsonKey(ignore: true)
  @override
  _$FurusatoPageStateCopyWith<_FurusatoPageState> get copyWith =>
      __$FurusatoPageStateCopyWithImpl<_FurusatoPageState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FurusatoPageStateToJson(this);
  }
}

abstract class _FurusatoPageState implements FurusatoPageState {
  const factory _FurusatoPageState(
      {int incomeTaxRate, dynamic residentTaxAmount}) = _$_FurusatoPageState;

  factory _FurusatoPageState.fromJson(Map<String, dynamic> json) =
      _$_FurusatoPageState.fromJson;

  @override
  int get incomeTaxRate => throw _privateConstructorUsedError;
  @override
  dynamic get residentTaxAmount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FurusatoPageStateCopyWith<_FurusatoPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
