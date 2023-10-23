import 'package:flutter/material.dart';
import 'package:reddit_clone/auth/screens/login_screen.dart';
import 'package:reddit_clone/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loginRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginScreen())
  }
);

final homeRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen())
  }
);