import 'package:flutter/material.dart';
import 'package:flutter_unicode_1/login.dart';
import 'package:flutter_unicode_1/movie_screen.dart';
import 'package:flutter_unicode_1/sign_up.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  Widget? activeScreen;
  @override
  void initState() {
    super.initState();
    activeScreen = LoginScreen(signUpCue: onSignUp, movieCue: showMovie);
  }

  void onSignUp() {
    setState(() {
      activeScreen = SignUpScreen(loginCue: showLogin);
    });
  }

  void showLogin() {
    setState(() {
      activeScreen = LoginScreen(signUpCue: onSignUp, movieCue: showMovie);
    });
  }

  void showMovie() {
    setState(() {
      activeScreen = MovieScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return activeScreen!;
  }
}
