import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/common/constants/firebase_constants.dart';
import 'package:reddit_clone/common/models/user.dart';
import 'package:reddit_clone/common/providers/providers.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(ref.read(firestoreProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  AuthRepository(FirebaseFirestore firestore) : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  void saveUserData(UserModel user) {
    _users.doc(user.uid).set(user.toMap());
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
