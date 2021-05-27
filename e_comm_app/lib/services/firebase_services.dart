import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String fetchUserID() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('Users');
}
