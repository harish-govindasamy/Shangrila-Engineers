import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/services/auth_service.dart';
import 'package:shangrila/services/firestore_service.dart';
import 'package:shangrila/services/user_service.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(FirebaseFirestore.instance),
        ),
        Provider<UserService>(
          create: (_) => UserService(FirebaseFirestore.instance),
        ),
        StreamProvider(initialData: null, create: (context) => context.read<AuthService>().authStateChanges)
      ],
      child: child,
    );
  }
}
