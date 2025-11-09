import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final CollectionReference _usersCollection = 
    FirebaseFirestore.instance.collection('users');

    Future<void> updateUserData({
      required String uid,
      required String email,
      required String name,
      required String lastname,
      required String username,
      required DateTime? birthdate,
    }) async{
      return await _usersCollection.doc(uid).set({
        'username' : username,
        'name': name,
        'lastname': lastname,
        'email': email,
        'totalScore': 0,
        'levelsCompleted': [],
      }, SetOptions(merge: true));
    }
}