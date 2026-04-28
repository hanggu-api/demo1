class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final String userType; // customer, restaurant, rider, admin
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  // Customer specific
  final String? defaultAddress;
  final List<String>? savedAddresses;
  
  // Restaurant specific
  final String? restaurantName;
  final String? restaurantDescription;
  final bool? isRestaurantActive;
  
  // Rider specific
  final bool? isRiderActive;
  final String? vehicleType;
  final double? currentLatitude;
  final double? currentLongitude;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    required this.userType,
    required this.createdAt,
    this.updatedAt,
    this.defaultAddress,
    this.savedAddresses,
    this.restaurantName,
    this.restaurantDescription,
    this.isRestaurantActive,
    this.isRiderActive,
    this.vehicleType,
    this.currentLatitude,
    this.currentLongitude,
  });
  
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      photoUrl: data['photoUrl'],
      userType: data['userType'] ?? 'customer',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      defaultAddress: data['defaultAddress'],
      savedAddresses: data['savedAddresses'] != null 
          ? List<String>.from(data['savedAddresses']) 
          : null,
      restaurantName: data['restaurantName'],
      restaurantDescription: data['restaurantDescription'],
      isRestaurantActive: data['isRestaurantActive'],
      isRiderActive: data['isRiderActive'],
      vehicleType: data['vehicleType'],
      currentLatitude: data['currentLatitude']?.toDouble(),
      currentLongitude: data['currentLongitude']?.toDouble(),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'userType': userType,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'defaultAddress': defaultAddress,
      'savedAddresses': savedAddresses,
      'restaurantName': restaurantName,
      'restaurantDescription': restaurantDescription,
      'isRestaurantActive': isRestaurantActive,
      'isRiderActive': isRiderActive,
      'vehicleType': vehicleType,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
    };
  }
  
  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? userType,
    DateTime? updatedAt,
    String? defaultAddress,
    List<String>? savedAddresses,
    String? restaurantName,
    String? restaurantDescription,
    bool? isRestaurantActive,
    bool? isRiderActive,
    String? vehicleType,
    double? currentLatitude,
    double? currentLongitude,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      userType: userType ?? this.userType,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantDescription: restaurantDescription ?? this.restaurantDescription,
      isRestaurantActive: isRestaurantActive ?? this.isRestaurantActive,
      isRiderActive: isRiderActive ?? this.isRiderActive,
      vehicleType: vehicleType ?? this.vehicleType,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
    );
  }
}
