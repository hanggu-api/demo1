/// Shared Models for Enatega Multi-vendor Food Delivery App

import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { customer, restaurant, rider, admin }

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  readyForPickup,
  pickedUp,
  onTheWay,
  delivered,
  cancelled
}

enum PaymentMethod { cash, card, stripe, paypal }

class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? photoUrl;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  
  // Customer specific
  final List<String>? savedAddresses;
  final List<String>? favoriteRestaurants;
  
  // Restaurant specific
  final String? restaurantId;
  final bool? isRestaurantVerified;
  
  // Rider specific
  final String? riderId;
  final bool? isRiderVerified;
  final bool? isAvailableForDelivery;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.photoUrl,
    required this.role,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.savedAddresses,
    this.favoriteRestaurants,
    this.restaurantId,
    this.isRestaurantVerified,
    this.riderId,
    this.isRiderVerified,
    this.isAvailableForDelivery,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'],
      phone: data['phone'],
      photoUrl: data['photoUrl'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${data['role']}',
        orElse: () => UserRole.customer,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null 
          ? (data['updatedAt'] as Timestamp).toDate() 
          : null,
      isActive: data['isActive'] ?? true,
      savedAddresses: data['savedAddresses']?.cast<String>(),
      favoriteRestaurants: data['favoriteRestaurants']?.cast<String>(),
      restaurantId: data['restaurantId'],
      isRestaurantVerified: data['isRestaurantVerified'],
      riderId: data['riderId'],
      isRiderVerified: data['isRiderVerified'],
      isAvailableForDelivery: data['isAvailableForDelivery'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
      'role': role.toString().split('.').last,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isActive': isActive,
      'savedAddresses': savedAddresses,
      'favoriteRestaurants': favoriteRestaurants,
      'restaurantId': restaurantId,
      'isRestaurantVerified': isRestaurantVerified,
      'riderId': riderId,
      'isRiderVerified': isRiderVerified,
      'isAvailableForDelivery': isAvailableForDelivery,
    };
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? photoUrl,
    DateTime? updatedAt,
    bool? isActive,
    List<String>? savedAddresses,
    List<String>? favoriteRestaurants,
    bool? isAvailableForDelivery,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      restaurantId: restaurantId,
      isRestaurantVerified: isRestaurantVerified,
      riderId: riderId,
      isRiderVerified: isRiderVerified,
      isAvailableForDelivery: isAvailableForDelivery ?? this.isAvailableForDelivery,
    );
  }
}

class DeliveryAddress {
  final String id;
  final String label;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final double latitude;
  final double longitude;
  final String? instructions;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.label,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.instructions,
    this.isDefault = false,
  });

  factory DeliveryAddress.fromFirestore(Map<String, dynamic> data, String id) {
    return DeliveryAddress(
      id: id,
      label: data['label'] ?? 'Home',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zipCode: data['zipCode'] ?? '',
      country: data['country'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      instructions: data['instructions'],
      isDefault: data['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'instructions': instructions,
      'isDefault': isDefault,
    };
  }
}

class Restaurant {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final List<String>? imageUrls;
  final String cuisineType;
  final double rating;
  final int totalReviews;
  final double deliveryFee;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final double minimumOrder;
  final bool isOpen;
  final List<String>? openingHours;
  final DeliveryAddress address;
  final double latitude;
  final double longitude;
  final List<String>? categories;
  final bool isFeatured;
  final DateTime createdAt;

  Restaurant({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.imageUrls,
    required this.cuisineType,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.deliveryFee = 0.0,
    this.deliveryTimeMin = 30,
    this.deliveryTimeMax = 45,
    this.minimumOrder = 0.0,
    this.isOpen = true,
    this.openingHours,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.categories,
    this.isFeatured = false,
    required this.createdAt,
  });

  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final addressData = data['address'] as Map<String, dynamic>?;
    
    return Restaurant(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'],
      imageUrl: data['imageUrl'],
      imageUrls: data['imageUrls']?.cast<String>(),
      cuisineType: data['cuisineType'] ?? 'Other',
      rating: (data['rating'] ?? 0.0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
      deliveryFee: (data['deliveryFee'] ?? 0.0).toDouble(),
      deliveryTimeMin: data['deliveryTimeMin'] ?? 30,
      deliveryTimeMax: data['deliveryTimeMax'] ?? 45,
      minimumOrder: (data['minimumOrder'] ?? 0.0).toDouble(),
      isOpen: data['isOpen'] ?? true,
      openingHours: data['openingHours']?.cast<String>(),
      address: addressData != null 
          ? DeliveryAddress.fromFirestore(addressData, 'addr_${doc.id}')
          : DeliveryAddress(
              id: 'addr_${doc.id}',
              label: 'Restaurant',
              address: data['addressText'] ?? '',
              city: data['city'] ?? '',
              state: data['state'] ?? '',
              zipCode: data['zipCode'] ?? '',
              country: data['country'] ?? '',
              latitude: (data['latitude'] ?? 0.0).toDouble(),
              longitude: (data['longitude'] ?? 0.0).toDouble(),
            ),
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      categories: data['categories']?.cast<String>(),
      isFeatured: data['isFeatured'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'cuisineType': cuisineType,
      'rating': rating,
      'totalReviews': totalReviews,
      'deliveryFee': deliveryFee,
      'deliveryTimeMin': deliveryTimeMin,
      'deliveryTimeMax': deliveryTimeMax,
      'minimumOrder': minimumOrder,
      'isOpen': isOpen,
      'openingHours': openingHours,
      'address': address.toFirestore(),
      'latitude': latitude,
      'longitude': longitude,
      'categories': categories,
      'isFeatured': isFeatured,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

class Product {
  final String id;
  final String restaurantId;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final List<ProductVariant>? variants;
  final List<ProductAddon>? addons;
  final List<String> categories;
  final bool isAvailable;
  final bool isVegetarian;
  final bool isSpicy;
  final int preparationTime;
  final int popularityScore;

  Product({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    this.variants,
    this.addons,
    required this.categories,
    this.isAvailable = true,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.preparationTime = 15,
    this.popularityScore = 0,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      restaurantId: data['restaurantId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'],
      imageUrl: data['imageUrl'],
      price: (data['price'] ?? 0.0).toDouble(),
      variants: (data['variants'] as List<dynamic>?)
          ?.map((v) => ProductVariant.fromMap(v as Map<String, dynamic>))
          .toList(),
      addons: (data['addons'] as List<dynamic>?)
          ?.map((a) => ProductAddon.fromMap(a as Map<String, dynamic>))
          .toList(),
      categories: (data['categories'] as List<dynamic>?)?.cast<String>() ?? [],
      isAvailable: data['isAvailable'] ?? true,
      isVegetarian: data['isVegetarian'] ?? false,
      isSpicy: data['isSpicy'] ?? false,
      preparationTime: data['preparationTime'] ?? 15,
      popularityScore: data['popularityScore'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'variants': variants?.map((v) => v.toMap()).toList(),
      'addons': addons?.map((a) => a.toMap()).toList(),
      'categories': categories,
      'isAvailable': isAvailable,
      'isVegetarian': isVegetarian,
      'isSpicy': isSpicy,
      'preparationTime': preparationTime,
      'popularityScore': popularityScore,
    };
  }
}

class ProductVariant {
  final String name;
  final double price;
  final bool isDefault;

  ProductVariant({
    required this.name,
    this.price = 0.0,
    this.isDefault = false,
  });

  factory ProductVariant.fromMap(Map<String, dynamic> map) {
    return ProductVariant(
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      isDefault: map['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'isDefault': isDefault,
    };
  }
}

class ProductAddon {
  final String name;
  final double price;
  final int? maxQuantity;

  ProductAddon({
    required this.name,
    this.price = 0.0,
    this.maxQuantity,
  });

  factory ProductAddon.fromMap(Map<String, dynamic> map) {
    return ProductAddon(
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      maxQuantity: map['maxQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'maxQuantity': maxQuantity,
    };
  }
}

class Order {
  final String id;
  final String customerId;
  final String restaurantId;
  final String? riderId;
  final List<OrderItem> items;
  final DeliveryAddress deliveryAddress;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final String? paymentId;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double total;
  final String? specialInstructions;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? preparedAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;

  Order({
    required this.id,
    required this.customerId,
    required this.restaurantId,
    this.riderId,
    required this.items,
    required this.deliveryAddress,
    required this.status,
    required this.paymentMethod,
    this.paymentId,
    required this.subtotal,
    required this.deliveryFee,
    this.tax = 0.0,
    this.discount = 0.0,
    required this.total,
    this.specialInstructions,
    required this.createdAt,
    this.confirmedAt,
    this.preparedAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final addressData = data['deliveryAddress'] as Map<String, dynamic>;
    
    return Order(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      restaurantId: data['restaurantId'] ?? '',
      riderId: data['riderId'],
      items: (data['items'] as List<dynamic>)
          .map((i) => OrderItem.fromMap(i as Map<String, dynamic>))
          .toList(),
      deliveryAddress: DeliveryAddress.fromFirestore(addressData, 'addr'),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${data['status']}',
        orElse: () => OrderStatus.pending,
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.toString() == 'PaymentMethod.${data['paymentMethod']}',
        orElse: () => PaymentMethod.cash,
      ),
      paymentId: data['paymentId'],
      subtotal: (data['subtotal'] ?? 0.0).toDouble(),
      deliveryFee: (data['deliveryFee'] ?? 0.0).toDouble(),
      tax: (data['tax'] ?? 0.0).toDouble(),
      discount: (data['discount'] ?? 0.0).toDouble(),
      total: (data['total'] ?? 0.0).toDouble(),
      specialInstructions: data['specialInstructions'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      confirmedAt: data['confirmedAt'] != null 
          ? (data['confirmedAt'] as Timestamp).toDate() 
          : null,
      preparedAt: data['preparedAt'] != null 
          ? (data['preparedAt'] as Timestamp).toDate() 
          : null,
      pickedUpAt: data['pickedUpAt'] != null 
          ? (data['pickedUpAt'] as Timestamp).toDate() 
          : null,
      deliveredAt: data['deliveredAt'] != null 
          ? (data['deliveredAt'] as Timestamp).toDate() 
          : null,
      cancelledAt: data['cancelledAt'] != null 
          ? (data['cancelledAt'] as Timestamp).toDate() 
          : null,
      cancellationReason: data['cancellationReason'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'restaurantId': restaurantId,
      'riderId': riderId,
      'items': items.map((i) => i.toMap()).toList(),
      'deliveryAddress': deliveryAddress.toFirestore(),
      'status': status.toString().split('.').last,
      'paymentMethod': paymentMethod.toString().split('.').last,
      'paymentId': paymentId,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'discount': discount,
      'total': total,
      'specialInstructions': specialInstructions,
      'createdAt': Timestamp.fromDate(createdAt),
      'confirmedAt': confirmedAt != null ? Timestamp.fromDate(confirmedAt!) : null,
      'preparedAt': preparedAt != null ? Timestamp.fromDate(preparedAt!) : null,
      'pickedUpAt': pickedUpAt != null ? Timestamp.fromDate(pickedUpAt!) : null,
      'deliveredAt': deliveredAt != null ? Timestamp.fromDate(deliveredAt!) : null,
      'cancelledAt': cancelledAt != null ? Timestamp.fromDate(cancelledAt!) : null,
      'cancellationReason': cancellationReason,
    };
  }

  Order copyWith({
    String? riderId,
    OrderStatus? status,
    DateTime? confirmedAt,
    DateTime? preparedAt,
    DateTime? pickedUpAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  }) {
    return Order(
      id: id,
      customerId: customerId,
      restaurantId: restaurantId,
      riderId: riderId ?? this.riderId,
      items: items,
      deliveryAddress: deliveryAddress,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      paymentId: paymentId,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      discount: discount,
      total: total,
      specialInstructions: specialInstructions,
      createdAt: createdAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      preparedAt: preparedAt ?? this.preparedAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String? productImageUrl;
  final int quantity;
  final double unitPrice;
  final ProductVariant? selectedVariant;
  final List<ProductAddon>? selectedAddons;
  final String? specialInstructions;

  OrderItem({
    required this.productId,
    required this.productName,
    this.productImageUrl,
    required this.quantity,
    required this.unitPrice,
    this.selectedVariant,
    this.selectedAddons,
    this.specialInstructions,
  });

  double get totalPrice {
    double price = unitPrice * quantity;
    if (selectedVariant != null) {
      price += selectedVariant!.price * quantity;
    }
    if (selectedAddons != null) {
      price += selectedAddons!.fold(
        0.0,
        (sum, addon) => sum + (addon.price * quantity),
      );
    }
    return price;
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImageUrl: map['productImageUrl'],
      quantity: map['quantity'] ?? 1,
      unitPrice: (map['unitPrice'] ?? 0.0).toDouble(),
      selectedVariant: map['selectedVariant'] != null
          ? ProductVariant.fromMap(map['selectedVariant'] as Map<String, dynamic>)
          : null,
      selectedAddons: (map['selectedAddons'] as List<dynamic>?)
          ?.map((a) => ProductAddon.fromMap(a as Map<String, dynamic>))
          .toList(),
      specialInstructions: map['specialInstructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'selectedVariant': selectedVariant?.toMap(),
      'selectedAddons': selectedAddons?.map((a) => a.toMap()).toList(),
      'specialInstructions': specialInstructions,
    };
  }
}

class Notification {
  final String id;
  final String userId;
  final String title;
  final String message;
  final String type;
  final String? orderId;
  final String? restaurantId;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.orderId,
    this.restaurantId,
    this.isRead = false,
    required this.createdAt,
  });

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Notification(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      type: data['type'] ?? 'general',
      orderId: data['orderId'],
      restaurantId: data['restaurantId'],
      isRead: data['isRead'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'message': message,
      'type': type,
      'orderId': orderId,
      'restaurantId': restaurantId,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

class Review {
  final String id;
  final String orderId;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String restaurantId;
  final double rating;
  final String? comment;
  final List<String>? imageUrls;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.restaurantId,
    required this.rating,
    this.comment,
    this.imageUrls,
    required this.createdAt,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userPhotoUrl: data['userPhotoUrl'],
      restaurantId: data['restaurantId'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      comment: data['comment'],
      imageUrls: data['imageUrls']?.cast<String>(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'userId': userId,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'restaurantId': restaurantId,
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
