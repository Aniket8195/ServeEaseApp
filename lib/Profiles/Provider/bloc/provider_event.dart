part of 'provider_bloc.dart';

@immutable
abstract class ProviderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// TabChanged event for changing tabs in the UI
class TabChanged extends ProviderEvent {
  final int tabIndex;

  TabChanged({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

// Future: You can add other events such as fetching bookings, updating profiles, etc.
class FetchBookings extends ProviderEvent {
  FetchBookings();
}
class ConfirmBooking extends ProviderEvent {
  final int bookingId;

  ConfirmBooking({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}
class CancelBooking extends ProviderEvent {
  final int bookingId;

  CancelBooking({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}
class CompleteBooking extends ProviderEvent {
  final int bookingId;

  CompleteBooking({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}

class AddReview extends ProviderEvent {
  final int seekerId;
  final int providerId;
  final double rating;
  final String comment;
  final bool seekerReview;
  final int bookingId;

  AddReview({required this.bookingId,required this.rating,required this.comment,required this.seekerReview,required this.seekerId,required this.providerId});

  @override
  List<Object> get props => [bookingId,rating,comment,seekerReview,seekerId,providerId];
}
