import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login();
  Future<UserEntity> currentUser();
}

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth auth;

  const FirebaseUserRepository(this.auth);

  @override
  Future<UserEntity> login() async {
    final firebaseUser = await auth.signInAnonymously();

    return UserEntity(
      id: firebaseUser.user.uid,
      displayName: firebaseUser.user.displayName,
      photoUrl: firebaseUser.user.photoUrl,
    );
  }

  @override
  Future<UserEntity> currentUser() async {
    final firebaseUser = await auth.currentUser();

    return UserEntity(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoUrl,
    );
  }
}
