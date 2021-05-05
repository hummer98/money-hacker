// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'app_router.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppPageTearOff {
  const _$AppPageTearOff();

  _Top top([String name = '/']) {
    return _Top(
      name,
    );
  }

  _Furusato furusato([String name = '/furusato']) {
    return _Furusato(
      name,
    );
  }

  _User user(UserPagePath path, [String name = '/user']) {
    return _User(
      path,
      name,
    );
  }
}

/// @nodoc
const $AppPage = _$AppPageTearOff();

/// @nodoc
mixin _$AppPage {
  String get name => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) top,
    required TResult Function(String name) furusato,
    required TResult Function(UserPagePath path, String name) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? top,
    TResult Function(String name)? furusato,
    TResult Function(UserPagePath path, String name)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Top value) top,
    required TResult Function(_Furusato value) furusato,
    required TResult Function(_User value) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Top value)? top,
    TResult Function(_Furusato value)? furusato,
    TResult Function(_User value)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppPageCopyWith<AppPage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPageCopyWith<$Res> {
  factory $AppPageCopyWith(AppPage value, $Res Function(AppPage) then) =
      _$AppPageCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$AppPageCopyWithImpl<$Res> implements $AppPageCopyWith<$Res> {
  _$AppPageCopyWithImpl(this._value, this._then);

  final AppPage _value;
  // ignore: unused_field
  final $Res Function(AppPage) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TopCopyWith<$Res> implements $AppPageCopyWith<$Res> {
  factory _$TopCopyWith(_Top value, $Res Function(_Top) then) =
      __$TopCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$TopCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$TopCopyWith<$Res> {
  __$TopCopyWithImpl(_Top _value, $Res Function(_Top) _then)
      : super(_value, (v) => _then(v as _Top));

  @override
  _Top get _value => super._value as _Top;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_Top(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Top with DiagnosticableTreeMixin implements _Top {
  const _$_Top([this.name = '/']);

  @JsonKey(defaultValue: '/')
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppPage.top(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppPage.top'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Top &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$TopCopyWith<_Top> get copyWith =>
      __$TopCopyWithImpl<_Top>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) top,
    required TResult Function(String name) furusato,
    required TResult Function(UserPagePath path, String name) user,
  }) {
    return top(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? top,
    TResult Function(String name)? furusato,
    TResult Function(UserPagePath path, String name)? user,
    required TResult orElse(),
  }) {
    if (top != null) {
      return top(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Top value) top,
    required TResult Function(_Furusato value) furusato,
    required TResult Function(_User value) user,
  }) {
    return top(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Top value)? top,
    TResult Function(_Furusato value)? furusato,
    TResult Function(_User value)? user,
    required TResult orElse(),
  }) {
    if (top != null) {
      return top(this);
    }
    return orElse();
  }
}

abstract class _Top implements AppPage {
  const factory _Top([String name]) = _$_Top;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TopCopyWith<_Top> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FurusatoCopyWith<$Res> implements $AppPageCopyWith<$Res> {
  factory _$FurusatoCopyWith(_Furusato value, $Res Function(_Furusato) then) =
      __$FurusatoCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$FurusatoCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$FurusatoCopyWith<$Res> {
  __$FurusatoCopyWithImpl(_Furusato _value, $Res Function(_Furusato) _then)
      : super(_value, (v) => _then(v as _Furusato));

  @override
  _Furusato get _value => super._value as _Furusato;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_Furusato(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Furusato with DiagnosticableTreeMixin implements _Furusato {
  const _$_Furusato([this.name = '/furusato']);

  @JsonKey(defaultValue: '/furusato')
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppPage.furusato(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppPage.furusato'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Furusato &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$FurusatoCopyWith<_Furusato> get copyWith =>
      __$FurusatoCopyWithImpl<_Furusato>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) top,
    required TResult Function(String name) furusato,
    required TResult Function(UserPagePath path, String name) user,
  }) {
    return furusato(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? top,
    TResult Function(String name)? furusato,
    TResult Function(UserPagePath path, String name)? user,
    required TResult orElse(),
  }) {
    if (furusato != null) {
      return furusato(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Top value) top,
    required TResult Function(_Furusato value) furusato,
    required TResult Function(_User value) user,
  }) {
    return furusato(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Top value)? top,
    TResult Function(_Furusato value)? furusato,
    TResult Function(_User value)? user,
    required TResult orElse(),
  }) {
    if (furusato != null) {
      return furusato(this);
    }
    return orElse();
  }
}

abstract class _Furusato implements AppPage {
  const factory _Furusato([String name]) = _$_Furusato;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FurusatoCopyWith<_Furusato> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $AppPageCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call({UserPagePath path, String name});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$AppPageCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? path = freezed,
    Object? name = freezed,
  }) {
    return _then(_User(
      path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as UserPagePath,
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(this.path, [this.name = '/user']);

  @override
  final UserPagePath path;
  @JsonKey(defaultValue: '/user')
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppPage.user(path: $path, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppPage.user'))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) top,
    required TResult Function(String name) furusato,
    required TResult Function(UserPagePath path, String name) user,
  }) {
    return user(path, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? top,
    TResult Function(String name)? furusato,
    TResult Function(UserPagePath path, String name)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(path, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Top value) top,
    required TResult Function(_Furusato value) furusato,
    required TResult Function(_User value) user,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Top value)? top,
    TResult Function(_Furusato value)? furusato,
    TResult Function(_User value)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class _User implements AppPage {
  const factory _User(UserPagePath path, [String name]) = _$_User;

  UserPagePath get path => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
