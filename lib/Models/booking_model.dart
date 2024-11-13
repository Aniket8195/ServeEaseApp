class BookingModel {
  final int bookingId;
  final String categoryName;
  final String status;
  final DateTime bookingDate;
  final double rating;
  final int providerId;
  final int seekerId;

  BookingModel({
    required this.bookingId,
    required this.categoryName,
    required this.status,
    required this.bookingDate,
    required this.rating,
    required this.providerId,
    required this.seekerId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      categoryName: json['categoryName'],
      status: json['status'],
      bookingDate: DateTime.parse(json['bookingDate']),
      rating: json['rating'],
      providerId: json['providerId'],
      seekerId: json['seekerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'categoryName': categoryName,
      'status': status,
      'bookingDate': bookingDate.toIso8601String(),
      'rating': rating,
    };
  }
}