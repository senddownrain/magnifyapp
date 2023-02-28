// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<_$_Day> {
  @override
  final int typeId = 1;

  @override
  _$_Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Day(
      id: fields[0] as String?,
      day: fields[1] as int?,
      title: fields[2] as String?,
      comment: fields[3] as String?,
      questions: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Day obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Day _$$_DayFromJson(Map<String, dynamic> json) => _$_Day(
      id: json['id'] as String?,
      day: json['day'] as int?,
      title: json['title'] as String?,
      comment: json['comment'] as String?,
      questions: json['questions'] as String?,
    );

Map<String, dynamic> _$$_DayToJson(_$_Day instance) => <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'title': instance.title,
      'comment': instance.comment,
      'questions': instance.questions,
    };
