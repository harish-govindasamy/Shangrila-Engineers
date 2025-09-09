import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> teamMembers;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.teamMembers = const [],
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Project(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      teamMembers: List<String>.from(data['teamMembers'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'teamMembers': teamMembers,
    };
  }
}
