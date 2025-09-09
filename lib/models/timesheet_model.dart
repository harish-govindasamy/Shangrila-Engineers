import 'package:cloud_firestore/cloud_firestore.dart';

class Timesheet {
  final String id;
  final String projectId;
  final DateTime date;
  final double hours;
  final String? notes;

  Timesheet({
    required this.id,
    required this.projectId,
    required this.date,
    required this.hours,
    this.notes,
  });

  factory Timesheet.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Timesheet(
      id: doc.id,
      projectId: data['projectId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      hours: (data['hours'] ?? 0).toDouble(),
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'projectId': projectId,
      'date': Timestamp.fromDate(date),
      'hours': hours,
      'notes': notes,
    };
  }
}
