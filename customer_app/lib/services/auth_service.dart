import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> get userData async {
    if (currentUser == null) return null;
    final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserCredential?> signUpWithEmailPassword(String email, String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': null,
        'photoUrl': null,
        'savedAddresses': [],
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'customer',
      });
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': userCredential.user!.displayName,
          'email': userCredential.user!.email,
          'phone': userCredential.user!.phoneNumber,
          'photoUrl': userCredential.user!.photoURL,
          'savedAddresses': [],
          'createdAt': FieldValue.serverTimestamp(),
          'role': 'customer',
        });
      }
      
      return userCredential;
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> updateProfile({String? name, String? phone}) async {
    if (currentUser == null) throw Exception('No user logged in');
    
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (phone != null) updates['phone'] = phone;
    
    await _firestore.collection('users').doc(currentUser!.uid).update(updates);
    
    if (name != null) {
      await currentUser!.updateDisplayName(name);
    }
  }

  Future<void> addAddress(String addressLabel, String address, double lat, double lng, String? details) async {
    if (currentUser == null) throw Exception('No user logged in');
    
    final newAddress = {
      'label': addressLabel,
      'address': address,
      'latitude': lat,
      'longitude': lng,
      'details': details,
    };
    
    await _firestore.collection('users').doc(currentUser!.uid).update({
      'savedAddresses': FieldValue.arrayUnion([newAddress]),
    });
  }
}
