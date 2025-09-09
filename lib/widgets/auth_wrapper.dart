import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/screens/home_screen.dart';
import 'package:shangrila/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    // Return either Home or Login screen
    if (user == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
