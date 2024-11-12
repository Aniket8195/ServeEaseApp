class BookingModel {
  final int bookingId;
  final String categoryName;
  final String status;
  final DateTime bookingDate;

  BookingModel({
    required this.bookingId,
    required this.categoryName,
    required this.status,
    required this.bookingDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      categoryName: json['categoryName'],
      status: json['status'],
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'categoryName': categoryName,
      'status': status,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}