import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final bool isCompleted;

  Task({required this.id, required this.name, required this.description, required this.isCompleted});

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
