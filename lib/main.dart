import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shangrila/screens/project_list_screen.dart';
import 'package:shangrila/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<FirestoreService>(
      create: (_) => FirestoreService(FirebaseFirestore.instance),
      child: MaterialApp(
        title: 'Shangri-La',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProjectListScreen(),
      ),
    );
  }
}
