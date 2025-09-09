import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shangrila/models/project_model.dart';
import 'package:shangrila/models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  // Project functions
  Stream<List<Project>> getProjects() {
    return _db.collection('projects').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Project.fromFirestore(doc)).toList());
  }

  Future<void> addProject(Project project) {
    return _db.collection('projects').add(project.toFirestore());
  }

  Future<void> updateProject(String id, Project project) {
    return _db.collection('projects').doc(id).update(project.toFirestore());
  }

  Future<void> deleteProject(String projectId) {
    return _db.collection('projects').doc(projectId).delete();
  }

  // Task functions
  Stream<List<Task>> getTasks(String projectId) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Future<void> addTask(String projectId, Task task) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .add(task.toFirestore());
  }

  Future<void> updateTask(String projectId, Task task) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toFirestore());
  }

  Future<void> deleteTask(String projectId, String taskId) {
    return _db
        .collection('projects')
        .doc(projectId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
