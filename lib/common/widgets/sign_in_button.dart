import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/auth/controller/auth_controller.dart';
import 'package:reddit_clone/common/constants/constants.dart';
import 'package:reddit_clone/theme/pallette.dart';

class SignInButton extends ConsumerWidget {
  final String authType;
  const SignInButton({Key? key, required this.authType}) : super(key: key);

  void handleLogin(WidgetRef ref, BuildContext context) {
    final controller = ref.read(authControllerProvider.notifier);
    controller.login(authType, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton.icon(
        onPressed: () => handleLogin(ref, context),
        label: Text(
          'Continue with $authType',
          style: const TextStyle(fontSize: 18, color: Pallete.whiteColor),
        ),
        icon: Image.asset(
          (authType == 'Google') ? Constants.googleLogo : Constants.appleLogo,
          height: 30,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.greyColor,
            minimumSize: const Size(double.infinity, 50)),
      ),
    );
  }
}
