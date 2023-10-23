import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/auth/controller/auth_controller.dart';
import 'package:reddit_clone/auth/controller/google_authenticator.dart';
import 'package:reddit_clone/auth/repository/auth_repository.dart';
import 'package:reddit_clone/common/models/user.dart';
import 'package:reddit_clone/common/routes.dart';
import 'package:reddit_clone/common/widgets/error_text.dart';
import 'package:reddit_clone/common/widgets/loader.dart';
import 'package:reddit_clone/firebase_options.dart';
import 'package:reddit_clone/theme/Pallette.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel =
        await ref.watch(authRepositoryProvider).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              title: 'Reddit',
              theme: Pallete.darkModeAppTheme,
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                    return homeRoute;
                  }
                }
                return loginRoute;
              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stack) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
