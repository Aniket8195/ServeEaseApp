class ServiceProviderModel {
  final int userId;
  final String name;
  final String email;
  final double rating;

  // Constructor
  ServiceProviderModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.rating,
  });

  // Factory constructor to create a ServiceProviderModel from JSON
  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      rating: json['rating'].toDouble(), // Convert rating to double
    );
  }

  // Method to convert ServiceProviderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'rating': rating,
    };
  }
}
