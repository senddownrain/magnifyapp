// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Day _$DayFromJson(Map<String, dynamic> json) {
  return _Day.fromJson(json);
}

/// @nodoc
mixin _$Day {
  @HiveField(0)
  String? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  int? get day => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get comment => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get questions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayCopyWith<Day> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayCopyWith<$Res> {
  factory $DayCopyWith(Day value, $Res Function(Day) then) =
      _$DayCopyWithImpl<$Res, Day>;
  @useResult
  $Res call(
      {@HiveField(0) String? id,
      @HiveField(1) int? day,
      @HiveField(2) String? title,
      @HiveField(3) String? comment,
      @HiveField(4) String? questions});
}

/// @nodoc
class _$DayCopyWithImpl<$Res, $Val extends Day> implements $DayCopyWith<$Res> {
  _$DayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? title = freezed,
    Object? comment = freezed,
    Object? questions = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      questions: freezed == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DayCopyWith<$Res> implements $DayCopyWith<$Res> {
  factory _$$_DayCopyWith(_$_Day value, $Res Function(_$_Day) then) =
      __$$_DayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? id,
      @HiveField(1) int? day,
      @HiveField(2) String? title,
      @HiveField(3) String? comment,
      @HiveField(4) String? questions});
}

/// @nodoc
class __$$_DayCopyWithImpl<$Res> extends _$DayCopyWithImpl<$Res, _$_Day>
    implements _$$_DayCopyWith<$Res> {
  __$$_DayCopyWithImpl(_$_Day _value, $Res Function(_$_Day) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? title = freezed,
    Object? comment = freezed,
    Object? questions = freezed,
  }) {
    return _then(_$_Day(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      questions: freezed == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'DayAdapter')
class _$_Day extends _Day with DiagnosticableTreeMixin {
  const _$_Day(
      {@HiveField(0) required this.id,
      @HiveField(1) this.day,
      @HiveField(2) this.title,
      @HiveField(3) this.comment,
      @HiveField(4) this.questions})
      : super._();

  factory _$_Day.fromJson(Map<String, dynamic> json) => _$$_DayFromJson(json);

  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final int? day;
  @override
  @HiveField(2)
  final String? title;
  @override
  @HiveField(3)
  final String? comment;
  @override
  @HiveField(4)
  final String? questions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Day(id: $id, day: $day, title: $title, comment: $comment, questions: $questions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Day'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('day', day))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('questions', questions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Day &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.questions, questions) ||
                other.questions == questions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, day, title, comment, questions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DayCopyWith<_$_Day> get copyWith =>
      __$$_DayCopyWithImpl<_$_Day>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DayToJson(
      this,
    );
  }
}

abstract class _Day extends Day {
  const factory _Day(
      {@HiveField(0) required final String? id,
      @HiveField(1) final int? day,
      @HiveField(2) final String? title,
      @HiveField(3) final String? comment,
      @HiveField(4) final String? questions}) = _$_Day;
  const _Day._() : super._();

  factory _Day.fromJson(Map<String, dynamic> json) = _$_Day.fromJson;

  @override
  @HiveField(0)
  String? get id;
  @override
  @HiveField(1)
  int? get day;
  @override
  @HiveField(2)
  String? get title;
  @override
  @HiveField(3)
  String? get comment;
  @override
  @HiveField(4)
  String? get questions;
  @override
  @JsonKey(ignore: true)
  _$$_DayCopyWith<_$_Day> get copyWith => throw _privateConstructorUsedError;
}
