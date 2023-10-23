import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/auth/controller/apple_authenticator.dart';
import 'package:reddit_clone/auth/controller/authenticator.dart';
import 'package:reddit_clone/auth/controller/google_authenticator.dart';

final authFactoryProvider = Provider((ref) => AuthFactory(ref));

class AuthFactory {
  final Ref _ref;

  AuthFactory(Ref ref) : _ref = ref;

  IAuthenticator? createAuthenticator(String authType) {
    switch (authType) {
      case 'Google':
        return _ref.read(googleAuthProvider);
      case 'Apple':
        return _ref.read(appleAuthProvider);
    }
    return null;
  }
}
