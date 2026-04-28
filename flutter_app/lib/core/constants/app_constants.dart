class AppConstants {
  // API Base URL (Firebase Cloud Functions)
  static const String baseUrl = 'YOUR_CLOUD_FUNCTIONS_URL';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String restaurantsCollection = 'restaurants';
  static const String ordersCollection = 'orders';
  static const String productsCollection = 'products';
  static const String categoriesCollection = 'categories';
  static const String ridersCollection = 'riders';
  static const String notificationsCollection = 'notifications';
  static const String reviewsCollection = 'reviews';
  
  // Storage Paths
  static const String userImagesPath = 'users/images';
  static const String restaurantImagesPath = 'restaurants/images';
  static const String productImagesPath = 'products/images';
  
  // Preferences Keys
  static const String userIdKey = 'userId';
  static const String userTokenKey = 'userToken';
  static const String userTypeKey = 'userType';
  static const String isLoggedInKey = 'isLoggedIn';
  
  // User Types
  static const String customerType = 'customer';
  static const String restaurantType = 'restaurant';
  static const String riderType = 'rider';
  static const String adminType = 'admin';
  
  // Order Statuses
  static const String orderPending = 'pending';
  static const String orderAccepted = 'accepted';
  static const String orderPreparing = 'preparing';
  static const String orderReadyForPickup = 'ready_for_pickup';
  static const String orderPickedUp = 'picked_up';
  static const String orderOnTheWay = 'on_the_way';
  static const String orderDelivered = 'delivered';
  static const String orderCancelled = 'cancelled';
  
  // Payment Methods
  static const String paymentCash = 'cash';
  static const String paymentCard = 'card';
  static const String paymentStripe = 'stripe';
  
  // Default Values
  static const double defaultDeliveryFee = 5.0;
  static const double minOrderAmount = 10.0;
  static const int defaultPageSize = 20;
}
