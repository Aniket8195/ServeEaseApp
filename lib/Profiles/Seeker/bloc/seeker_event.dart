part of 'seeker_bloc.dart';

@immutable
abstract class SeekerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabChanged extends SeekerEvent {
  final int tabIndex;
  TabChanged({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class FetchCategories extends SeekerEvent {
  FetchCategories();
}

class FetchBookings extends SeekerEvent {
  FetchBookings();
}
class CategorySelected extends SeekerEvent {
  final int category;
  CategorySelected({required this.category});

  @override
  List<Object> get props => [category];
}
class BookingEvent extends SeekerEvent {
  final int providerID;
  final int seekerID;
  final int categoryID;
  final DateTime dateTime;

  BookingEvent({required this.providerID, required this.seekerID, required this.categoryID, required this.dateTime});
  @override
  List<Object> get props => [providerID, seekerID, categoryID, dateTime];
}

class AddReview extends SeekerEvent {
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

class FetchProfile extends SeekerEvent {
  FetchProfile();
}
class CompletePayment extends SeekerEvent{
  final int bookingID;
  final double amount;
  CompletePayment({required this.bookingID,required this.amount});
  @override
  List<Object> get props => [bookingID,amount];
}