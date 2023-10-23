import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/auth/controller/auth_controller.dart';
import 'package:reddit_clone/common/widgets/loader.dart';
import 'package:reddit_clone/common/widgets/sign_in_button.dart';
import 'package:reddit_clone/common/constants/constants.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.appLogo,
          height: 40,
        ),
        centerTitle: true,
        actions: const [
          Text(
            'Skip',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              (isLoading) ? const Loader() : Container(),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Let\'s dive into anything',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Constants.loginImage,
                  height: 400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SignInButton(
                authType: 'Google',
              ),
              const SignInButton(
                authType: 'Apple',
              ),
            ],
          )
        ],
      ),
    );
  }
}
