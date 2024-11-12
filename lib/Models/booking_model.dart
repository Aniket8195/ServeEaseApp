class BookingModel {
  final int providerId;
  final int seekerId;
  final int categoryId;
  final DateTime bookingDate;

  BookingModel({
    required this.providerId,
    required this.seekerId,
    required this.categoryId,
    required this.bookingDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      providerId: json['providerId'],
      seekerId: json['seekerId'],
      categoryId: json['categoryId'],
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerId': providerId,
      'seekerId': seekerId,
      'categoryId': categoryId,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}