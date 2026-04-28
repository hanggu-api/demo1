import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String restaurantId;
  final String? riderId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String status;
  final String paymentMethod;
  final String? paymentStatus;
  final DeliveryAddress deliveryAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? acceptedAt;
  final DateTime? preparingAt;
  final DateTime? readyForPickupAt;
  final DateTime? pickedUpAt;
  final DateTime? onTheWayAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final String? specialInstructions;
  final double? riderLatitude;
  final double? riderLongitude;
  
  OrderModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    this.riderId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.paymentMethod,
    this.paymentStatus,
    required this.deliveryAddress,
    required this.createdAt,
    this.updatedAt,
    this.acceptedAt,
    this.preparingAt,
    this.readyForPickupAt,
    this.pickedUpAt,
    this.onTheWayAt,
    this.deliveredAt,
    this.cancelledAt,
    this.cancellationReason,
    this.specialInstructions,
    this.riderLatitude,
    this.riderLongitude,
  });
  
  factory OrderModel.fromMap(Map<String, dynamic> data, String documentId) {
    return OrderModel(
      id: documentId,
      userId: data['userId'] ?? '',
      restaurantId: data['restaurantId'] ?? '',
      riderId: data['riderId'],
      items: (data['items'] as List?)?.map((item) => OrderItem.fromMap(item)).toList() ?? [],
      subtotal: (data['subtotal'] ?? 0).toDouble(),
      deliveryFee: (data['deliveryFee'] ?? 0).toDouble(),
      tax: (data['tax'] ?? 0).toDouble(),
      total: (data['total'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      paymentMethod: data['paymentMethod'] ?? 'cash',
      paymentStatus: data['paymentStatus'],
      deliveryAddress: DeliveryAddress.fromMap(data['deliveryAddress'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      acceptedAt: (data['acceptedAt'] as Timestamp?)?.toDate(),
      preparingAt: (data['preparingAt'] as Timestamp?)?.toDate(),
      readyForPickupAt: (data['readyForPickupAt'] as Timestamp?)?.toDate(),
      pickedUpAt: (data['pickedUpAt'] as Timestamp?)?.toDate(),
      onTheWayAt: (data['onTheWayAt'] as Timestamp?)?.toDate(),
      deliveredAt: (data['deliveredAt'] as Timestamp?)?.toDate(),
      cancelledAt: (data['cancelledAt'] as Timestamp?)?.toDate(),
      cancellationReason: data['cancellationReason'],
      specialInstructions: data['specialInstructions'],
      riderLatitude: data['riderLatitude']?.toDouble(),
      riderLongitude: data['riderLongitude']?.toDouble(),
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
      'tax': tax,
      'total': total,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'deliveryAddress': deliveryAddress.toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'acceptedAt': acceptedAt != null ? Timestamp.fromDate(acceptedAt!) : null,
      'preparingAt': preparingAt != null ? Timestamp.fromDate(preparingAt!) : null,
      'readyForPickupAt': readyForPickupAt != null ? Timestamp.fromDate(readyForPickupAt!) : null,
      'pickedUpAt': pickedUpAt != null ? Timestamp.fromDate(pickedUpAt!) : null,
      'onTheWayAt': onTheWayAt != null ? Timestamp.fromDate(onTheWayAt!) : null,
      'deliveredAt': deliveredAt != null ? Timestamp.fromDate(deliveredAt!) : null,
      'cancelledAt': cancelledAt != null ? Timestamp.fromDate(cancelledAt!) : null,
      'cancellationReason': cancellationReason,
      'specialInstructions': specialInstructions,
      'riderLatitude': riderLatitude,
      'riderLongitude': riderLongitude,
    };
  }
  
  OrderModel copyWith({
    String? riderId,
    String? status,
    String? paymentStatus,
    DateTime? updatedAt,
    DateTime? acceptedAt,
    DateTime? preparingAt,
    DateTime? readyForPickupAt,
    DateTime? pickedUpAt,
    DateTime? onTheWayAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    double? riderLatitude,
    double? riderLongitude,
  }) {
    return OrderModel(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      riderId: riderId ?? this.riderId,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      total: total,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryAddress: deliveryAddress,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      preparingAt: preparingAt ?? this.preparingAt,
      readyForPickupAt: readyForPickupAt ?? this.readyForPickupAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      onTheWayAt: onTheWayAt ?? this.onTheWayAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      specialInstructions: specialInstructions,
      riderLatitude: riderLatitude ?? this.riderLatitude,
      riderLongitude: riderLongitude ?? this.riderLongitude,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String? productImage;
  final int quantity;
  final double price;
  final List<String>? extras;
  final String? specialInstructions;
  
  OrderItem({
    required this.productId,
    required this.productName,
    this.productImage,
    required this.quantity,
    required this.price,
    this.extras,
    this.specialInstructions,
  });
  
  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      productImage: data['productImage'],
      quantity: data['quantity'] ?? 1,
      price: (data['price'] ?? 0).toDouble(),
      extras: data['extras'] != null ? List<String>.from(data['extras']) : null,
      specialInstructions: data['specialInstructions'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
      'price': price,
      'extras': extras,
      'specialInstructions': specialInstructions,
    };
  }
  
  double get totalPrice => price * quantity;
}

class DeliveryAddress {
  final String id;
  final String label;
  final String address;
  final String? apartment;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final double latitude;
  final double longitude;
  final String? instructions;
  
  DeliveryAddress({
    required this.id,
    required this.label,
    required this.address,
    this.apartment,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.instructions,
  });
  
  factory DeliveryAddress.fromMap(Map<String, dynamic> data) {
    return DeliveryAddress(
      id: data['id'] ?? '',
      label: data['label'] ?? 'Home',
      address: data['address'] ?? '',
      apartment: data['apartment'],
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zipCode: data['zipCode'] ?? '',
      country: data['country'] ?? '',
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      instructions: data['instructions'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'address': address,
      'apartment': apartment,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'instructions': instructions,
    };
  }
}
