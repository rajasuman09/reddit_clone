import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/common/constants/constants.dart';
import 'package:reddit_clone/common/models/user.dart';
import 'package:reddit_clone/common/providers/providers.dart';
import 'package:reddit_clone/auth/controller/authenticator.dart';

final googleAuthProvider = Provider((ref) => GoogleAuthenticator(
    googleSignIn: ref.read(googleSignInProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firestoreProvider)));

final authStateChangeProvider =
    StreamProvider((ref) => ref.read(googleAuthProvider).authStateChange);

class GoogleAuthenticator implements IAuthenticator {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  GoogleAuthenticator(
      {required GoogleSignIn googleSignIn,
      required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _googleSignIn = googleSignIn,
        _firebaseAuth = firebaseAuth;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  @override
  Future<(UserModel, bool)> login() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          profilePic: userCredential.user?.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          karma: 0,
          awards: [],
          uid: userCredential.user!.uid,
          isAuthenticated: true);
      return (user, userCredential.additionalUserInfo!.isNewUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void logout() {
    print('google logging out');
  }
}
