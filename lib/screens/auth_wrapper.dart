import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/screens/dashboard_screen.dart';
import 'package:shangrila/screens/login_screen.dart';
import 'package:shangrila/screens/timesheet_screen.dart';
import 'package:shangrila/services/user_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser == null) {
      return const LoginScreen();
    }

    return StreamProvider<AppUser?>.value(
      value: Provider.of<UserService>(context).getUser(firebaseUser.uid),
      initialData: null,
      child: Consumer<AppUser?>(
        builder: (context, user, child) {
          if (user == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          switch (user.role) {
            case 'admin':
            case 'principal':
              return const DashboardScreen();
            case 'employee':
              return const TimesheetScreen();
            default:
              return const LoginScreen(); // Or a default screen
          }
        },
      ),
    );
  }
}
