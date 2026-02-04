import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_bott/infrastructure/user/models/user_model.dart';

@lazySingleton
class FirebaseUserDataSource {
  FirebaseUserDataSource(this._firebaseAuth, this._firestore);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    final doc = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!..['id'] = doc.id);
    }
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user!;
    final doc = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (doc.exists) {
      return UserModel.fromJson(doc.data()!..['id'] = doc.id);
    }
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? name,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user!;
    final userModel = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: name ?? firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );

    await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userModel.toJson());
    return userModel;
  }

  Future<void> signOut() => _firebaseAuth.signOut();
}
