import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Get current user stream
  Stream<UserModel?> get currentUserStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
  
  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  
  // Update user profile
  Future<bool> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();
      await _firestore.collection('users').doc(userId).update(data);
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }
  
  // Save address for user
  Future<bool> saveAddress(String userId, Map<String, dynamic> addressData) async {
    try {
      final addressRef = _firestore.collection('users').doc(userId).collection('addresses').doc();
      addressData['id'] = addressRef.id;
      addressData['createdAt'] = FieldValue.serverTimestamp();
      await addressRef.set(addressData);
      
      // Update default address if it's the first one
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists || userDoc.data()?['defaultAddress'] == null) {
        await _firestore.collection('users').doc(userId).update({
          'defaultAddress': addressRef.id,
        });
      }
      
      return true;
    } catch (e) {
      print('Error saving address: $e');
      return false;
    }
  }
  
  // Get user addresses
  Stream<List<Map<String, dynamic>>> getUserAddresses(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  
  // Delete address
  Future<bool> deleteAddress(String userId, String addressId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('addresses').doc(addressId).delete();
      return true;
    } catch (e) {
      print('Error deleting address: $e');
      return false;
    }
  }
}
