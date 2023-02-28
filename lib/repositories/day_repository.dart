import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:magnifyapp/general_provider.dart';
import 'package:magnifyapp/model/Today.dart';
import 'package:magnifyapp/model/day_model.dart';
import 'package:magnifyapp/repositories/custom_exception.dart';

import '../model/note_model.dart';

abstract class BaseDayRepository {
  Future<List<Day>> retrieveItems();
  //Future<List<Day>> retrieveItems({required String userId});
  // Future<String> createItem({required String userId, required Item item});
  // Future<void> updateItem({required String userId, required Item item});
  // Future<void> deleteItem({required String userId, required String itemId});
}

final dayRepositoryProvider =
    Provider<DayRepository>((ref) => DayRepository(ref));

class DayRepository implements BaseDayRepository {
  final Ref _ref;

  const DayRepository(this._ref);

  @override
  Future<List<Day>> retrieveItems() async {
    try {
      final snap =
          await _ref.read(firebaseFirestoreProvider).collection('days').get();
//print(snap.docs.map((doc) => Day.fromDocument(doc)));

      //return snap.docs.map((doc) => Day.fromDocument(doc)).toList();
      return snap.docs
          .map((doc) => Day.fromDocument(doc))
          .toList(); //Future.value(<Day>[]);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Day> getItem(int id) async {
    try {
      final doc = await _ref
          .read(firebaseFirestoreProvider)
          .collection('days')
          .doc('${id}')
          .get();
//print(snap.docs.map((doc) => Day.fromDocument(doc)));

      //return snap.docs.map((doc) => Day.fromDocument(doc)).toList();
      return Day.fromDocument(doc); //Future.value(<Day>[]);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Day>> retrieveItemsFromCache() async {
    try {
      var days = await Hive.openBox<Day>('days');
      return days.values.toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Box<Day>> openItems() async {
    return await Hive.openBox<Day>('days');
  }

  loadItems() async {
    try {
      var items = await retrieveItems();

      var days = await Hive.openBox<Day>('days');

      days.deleteAll(days.keys);
      days.putAll(Map.fromIterable(items, key: (v) => v.id, value: (v) => v));
      print(days.length);
      days.values.forEach((element) {
        print('${element.id} - ${element.title}');
      });
      //return snap.docs.map((doc) => Day.fromDocument(doc)).toList();value(<Day>[]);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
final dbProvider =
    Provider<Database>((ref) => Database(ref));

class Database {
  final Ref _ref;

  const Database(this._ref);

  updateAllCache() async {
    await updateCache<Day>('days', Day.fromDocument);
    await updateCache<Note>('notes', Note.fromDocument);
  }

  Future<Today> getToday() async {
    var days = await Hive.openBox<Day>('days');
    var notes = await Hive.openBox<Note>('notes');

    var dayNum = Jiffy().dayOfYear;
    var dayStartNum = Jiffy([2023,2,22]).dayOfYear;
    var currentDay = dayNum - dayStartNum + 1;
    // print(dayStartNum);
    // print(dayNum - dayStartNum + 1);
    // print(weekNum - 1);

    var thisDay = days.get(currentDay.toString());
    //print(thisDay);
    if(thisDay == null){
      await this.updateAllCache();
      thisDay = days.get(currentDay.toString());
    }
    var magbel = notes.get('magbel');
 var magru = notes.get('magru');
  var litsmir = notes.get('litsmir');
   var listdov = notes.get('litdov');

    return Today(thisDay!, magbel, magru, litsmir, listdov);

  }

  updateCache<T>(String dictName, T Function(DocumentSnapshot arg) f) async {
    try {
      final snap =
          await _ref.read(firebaseFirestoreProvider).collection(dictName).get();

      var items = await Hive.openBox<T>(dictName);

      items.deleteAll(items.keys);
      items.putAll(Map.fromIterable(snap.docs.map((doc) => f(doc)),
          key: (v) => v.id, value: (v) => v));
      print(items.length);
      items.values.forEach((element) {
        print(element.toString());
      });
      //return snap.docs.map((doc) => Day.fromDocument(doc)).toList();value(<Day>[]);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
