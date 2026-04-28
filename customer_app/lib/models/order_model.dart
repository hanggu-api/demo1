import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus { pending, confirmed, preparing, ready, onTheWay, delivered, cancelled }

class OrderModel {
  final String id;
  final String userId;
  final String restaurantId;
  final String? riderId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final DeliveryAddress deliveryAddress;
  final String? paymentMethod;
  final String? paymentId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? specialInstructions;

  OrderModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    this.riderId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.deliveryAddress,
    this.paymentMethod,
    this.paymentId,
    required this.createdAt,
    this.updatedAt,
    this.specialInstructions,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      restaurantId: data['restaurantId'] ?? '',
      riderId: data['riderId'],
      items: (data['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      subtotal: (data['subtotal'] ?? 0).toDouble(),
      deliveryFee: (data['deliveryFee'] ?? 0).toDouble(),
      total: (data['total'] ?? 0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => OrderStatus.pending,
      ),
      deliveryAddress: DeliveryAddress.fromMap(data['deliveryAddress']),
      paymentMethod: data['paymentMethod'],
      paymentId: data['paymentId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      specialInstructions: data['specialInstructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'restaurantId': restaurantId,
      'riderId': riderId,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'status': status.name,
      'deliveryAddress': deliveryAddress.toMap(),
      'paymentMethod': paymentMethod,
      'paymentId': paymentId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'specialInstructions': specialInstructions,
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    String? restaurantId,
    String? riderId,
    List<OrderItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    OrderStatus? status,
    DeliveryAddress? deliveryAddress,
    String? paymentMethod,
    String? paymentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? specialInstructions,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      riderId: riderId ?? this.riderId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentId: paymentId ?? this.paymentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}

class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final List<String> extras;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.extras = const [],
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 0,
      extras: List<String>.from(map['extras'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'extras': extras,
    };
  }
}

class DeliveryAddress {
  final String label;
  final String address;
  final double latitude;
  final double longitude;
  final String? details;

  DeliveryAddress({
    required this.label,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.details,
  });

  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      label: map['label'] ?? '',
      address: map['address'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      details: map['details'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'details': details,
    };
  }
}
