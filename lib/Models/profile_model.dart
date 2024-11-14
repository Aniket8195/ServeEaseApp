class UserProfile {
  int userId;
  String name;
  String email;
  String role;
  double rating;
  int totalBookings;
  int completedBookings;
  int activeBookings;

  // Constructor
  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.rating,
    required this.totalBookings,
    required this.completedBookings,
    required this.activeBookings,
  });

  // Factory method to create a User object from a JSON map
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      rating: json['rating'].toDouble(), // Ensure it's a double
      totalBookings: json['totalBookings'],
      completedBookings: json['completedBookings'],
      activeBookings: json['activeBookings'],
    );
  }

  // Method to convert a User object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'rating': rating,
      'totalBookings': totalBookings,
      'completedBookings': completedBookings,
      'activeBookings': activeBookings,
    };
  }
}
