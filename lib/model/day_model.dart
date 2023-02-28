import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'day_model.freezed.dart';
part 'day_model.g.dart';

@freezed
class Day with _$Day {
  const Day._();

  @HiveType(typeId: 1, adapterName: 'DayAdapter')
  const factory Day({
    @HiveField(0) required String? id,
    @HiveField(1) int? day,
    @HiveField(2) String? title,
    @HiveField(3) String? comment,
    @HiveField(4)  String? questions,
  }) = _Day;

  factory Day.empty() => Day(id: '1', title: '', questions: '', comment: '');

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  factory Day.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    //print(data);
    return Day.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
