/// Firebase Configuration and Initialization
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;

  // Collections references
  static CollectionReference get users => firestore.collection('users');
  static CollectionReference get restaurants => firestore.collection('restaurants');
  static CollectionReference get products => firestore.collection('products');
  static CollectionReference get orders => firestore.collection('orders');
  static CollectionReference get notifications => firestore.collection('notifications');
  static CollectionReference get reviews => firestore.collection('reviews');
  static CollectionReference get riders => firestore.collection('riders');
}
