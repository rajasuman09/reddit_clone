import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/common/constants/constants.dart';
import 'package:reddit_clone/common/models/user.dart';
import 'package:reddit_clone/common/providers/providers.dart';
import 'package:reddit_clone/auth/controller/authenticator.dart';

final appleAuthProvider = Provider(
    (ref) => AppleAuthenticator(appleSignIn: ref.read(googleSignInProvider)));

class AppleAuthenticator implements IAuthenticator {
  final GoogleSignIn _appleSignIn;
  AppleAuthenticator({required GoogleSignIn appleSignIn})
      : _appleSignIn = appleSignIn;

  @override
  Future<(UserModel, bool)> login() async {
    print('apple signing in');
    final user = UserModel(
          name: 'No Name',
          profilePic: '',
          banner: Constants.bannerDefault,
          karma: 0,
          awards: [],
          uid: '',
          isAuthenticated: true);
    return (user, false);
  }

  @override
  void logout() {
    print('apple logging out');
  }
}
