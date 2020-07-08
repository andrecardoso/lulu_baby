import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lulu_baby/repository/baby_event_entity.dart';
import 'package:lulu_baby/repository/user_entity.dart';
import 'package:lulu_baby/repository/baby_entity.dart';

abstract class BabiesRepository {
  Stream<List<BabyEntity>> babies(UserEntity user);

  Future<void> saveBaby(BabyEntity baby);

  Future<void> addBabyEvent(BabyEntity baby, BabyEventEntity event);

  Stream<List<BabyEventEntity>> babyEvents(BabyEntity baby);
}

class FirestoreBabiesRepository implements BabiesRepository {
  final Firestore firestore;

  const FirestoreBabiesRepository(this.firestore);

  @override
  Future<void> addBabyEvent(BabyEntity baby, BabyEventEntity event) {
    return firestore
        .collection('babies')
        .document(baby.id)
        .collection('events')
        .add(event.toJson());
  }

  @override
  Stream<List<BabyEntity>> babies(UserEntity user) {
    return firestore.collection('babies').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return BabyEntity(
            id: doc.documentID,
            name: doc['name'],
            gender: doc['gender'],
            birthDate: DateTime.parse(doc['birthdate'] as String));
      }).toList();
    });
  }

  @override
  Stream<List<BabyEventEntity>> babyEvents(BabyEntity baby) {
    var snapshots = firestore
        .collection('babies')
        .document(baby.id)
        .collection('events')
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.documents.map((doc) {
        return BabyEventEntity.fromJson({...doc.data, 'id': doc.documentID});
      }).toList();
    });
  }

  @override
  Future<void> saveBaby(BabyEntity baby) {
    return firestore
        .collection('babies')
        .document(baby.id)
        .setData(baby.toJson());
  }
}
