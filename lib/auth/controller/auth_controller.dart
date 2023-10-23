import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/auth/controller/auth_factory.dart';
import 'package:reddit_clone/auth/repository/auth_repository.dart';
import 'package:reddit_clone/common/models/user.dart';
import 'package:reddit_clone/common/utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(ref, ref.read(authRepositoryProvider)));

final userProvider = StateProvider<UserModel?>((ref) => null);

final userStateChangeProvider = StreamProvider.family(
    (ref, String uid) => ref.read(authControllerProvider.notifier).userStateChange(uid));

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final AuthRepository _authRepository;
  AuthController(Ref ref, AuthRepository authRepository)
      : _ref = ref,
        _authRepository = authRepository,
        super(false);

  Stream<UserModel> userStateChange(String uid) =>
      _authRepository.getUserData(uid);

  void login(String authType, BuildContext context) async {
    UserModel user;
    bool isNewUser;

    final authFactory = _ref.read(authFactoryProvider);
    final authenticator = authFactory.createAuthenticator(authType);
    state = true;
    (user, isNewUser) = await authenticator?.login();
    state = false;

    if (isNewUser) {
      _authRepository.saveUserData(user);
      showSnackBar(context, 'User registration success');
    } else {
      user = await _authRepository.getUserData(user.uid).first;
    }
    _ref.read(userProvider.notifier).update((state) => user);
  }

  void logout(String authType) {
    final authFactory = _ref.read(authFactoryProvider);
    final authenticator = authFactory.createAuthenticator(authType);
    authenticator?.logout();
  }
}
