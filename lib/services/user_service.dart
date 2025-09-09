import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shangrila/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  CollectionReference get _userCollection => _firestore.collection('users');

  Stream<AppUser?> getUser(String uid) {
    return _userCollection
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.exists
            ? AppUser.fromFirestore(snapshot)
            : null);
  }

  Stream<List<AppUser>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromFirestore(doc)).toList();
    });
  }

  Future<void> createUser(AppUser user) {
    return _userCollection.doc(user.uid).set(user.toFirestore());
  }

  Future<void> updateUser(AppUser user) {
    return _userCollection.doc(user.uid).update(user.toFirestore());
  }

  Future<void> deleteUser(String uid) {
    return _userCollection.doc(uid).delete();
  }

  Future<void> updateUserRole(String uid, String newRole) {
    return _userCollection.doc(uid).update({'role': newRole});
  }
}
