import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Create new order
  Future<String?> createOrder(OrderModel order) async {
    try {
      final orderRef = _firestore.collection('orders').doc();
      order.id = orderRef.id;
      await orderRef.set(order.toMap());
      return orderRef.id;
    } catch (e) {
      print('Error creating order: $e');
      return null;
    }
  }
  
  // Get order by ID
  Stream<OrderModel?> getOrderById(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return OrderModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
  
  // Get user orders
  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  
  // Get restaurant orders
  Stream<List<OrderModel>> getRestaurantOrders(String restaurantId) {
    return _firestore
        .collection('orders')
        .where('restaurantId', isEqualTo: restaurantId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  
  // Get rider orders
  Stream<List<OrderModel>> getRiderOrders(String riderId) {
    return _firestore
        .collection('orders')
        .where('riderId', isEqualTo: riderId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  
  // Update order status
  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      final data = <String, dynamic>{
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      // Add timestamp for specific statuses
      switch (status) {
        case 'accepted':
          data['acceptedAt'] = FieldValue.serverTimestamp();
          break;
        case 'preparing':
          data['preparingAt'] = FieldValue.serverTimestamp();
          break;
        case 'ready_for_pickup':
          data['readyForPickupAt'] = FieldValue.serverTimestamp();
          break;
        case 'picked_up':
          data['pickedUpAt'] = FieldValue.serverTimestamp();
          break;
        case 'on_the_way':
          data['onTheWayAt'] = FieldValue.serverTimestamp();
          break;
        case 'delivered':
          data['deliveredAt'] = FieldValue.serverTimestamp();
          break;
        case 'cancelled':
          data['cancelledAt'] = FieldValue.serverTimestamp();
          break;
      }
      
      await _firestore.collection('orders').doc(orderId).update(data);
      return true;
    } catch (e) {
      print('Error updating order status: $e');
      return false;
    }
  }
  
  // Assign rider to order
  Future<bool> assignRider(String orderId, String riderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'riderId': riderId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error assigning rider: $e');
      return false;
    }
  }
  
  // Update rider location
  Future<bool> updateRiderLocation(String orderId, double latitude, double longitude) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'riderLatitude': latitude,
        'riderLongitude': longitude,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error updating rider location: $e');
      return false;
    }
  }
  
  // Cancel order
  Future<bool> cancelOrder(String orderId, String reason) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': 'cancelled',
        'cancellationReason': reason,
        'cancelledAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error cancelling order: $e');
      return false;
    }
  }
}
