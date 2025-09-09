import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shangrila/models/user_model.dart';
import 'package:shangrila/models/user_role.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService(this._firestore);

  CollectionReference get _userCollection => _firestore.collection('users');

  Stream<UserModel?> getUser(String uid) {
    return _userCollection
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.exists
            ? UserModel.fromFirestore(snapshot)
            : null);
  }

  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> createUser(UserModel user) {
    return _userCollection.doc(user.uid).set(user.toFirestore());
  }

  Future<void> updateUser(UserModel user) {
    return _userCollection.doc(user.uid).update(user.toFirestore());
  }

  Future<void> deleteUser(String uid) {
    return _userCollection.doc(uid).delete();
  }

  Future<void> updateUserRole(String uid, UserRole newRole) {
    return _userCollection.doc(uid).update({'role': newRole.toString().split('.').last});
  }
}
