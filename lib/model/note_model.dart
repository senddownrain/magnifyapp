import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class Note with _$Note{
  const Note._();

  @HiveType(typeId: 2, adapterName: 'NoteAdapter')
  const factory Note({
    @HiveField(0) required String? id,
    @HiveField(1) String? text,
    @HiveField(2) String? title,
    @HiveField(3) int? num,
    }
  ) = _Note;

 factory Note.empty() => Note(id: '1', text: '', title: '', num: 0);

   factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json); 

   factory Note.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    
    return Note.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}