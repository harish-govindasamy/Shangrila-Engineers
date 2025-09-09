import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shangrila/models/timesheet_model.dart';

class TimesheetService {
  final CollectionReference _timesheetCollection =
      FirebaseFirestore.instance.collection('timesheets');

  Stream<List<Timesheet>> getTimesheets() {
    return _timesheetCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Timesheet.fromFirestore(doc)).toList();
    });
  }

  Future<void> addTimesheet(Timesheet timesheet) {
    return _timesheetCollection.add(timesheet.toFirestore());
  }

  Future<void> updateTimesheet(Timesheet timesheet) {
    return _timesheetCollection.doc(timesheet.id).update(timesheet.toFirestore());
  }

  Future<void> deleteTimesheet(String id) {
    return _timesheetCollection.doc(id).delete();
  }
}
