part of 'seeker_bloc.dart';

@immutable
abstract class SeekerState extends Equatable {
  final int tabIndex;

  const SeekerState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class SeekerInitial extends SeekerState {
  const SeekerInitial({required super.tabIndex});
}

class FetchedCategories extends SeekerState {
  final List<CategoryModel> categories;

  const FetchedCategories({required this.categories, required super.tabIndex});

  @override
  List<Object> get props => [tabIndex, categories];
}

class BookingsFetched extends SeekerState {
  final List<BookingModel> bookings;

  const BookingsFetched({required this.bookings, required super.tabIndex});

  @override
  List<Object> get props => [tabIndex, bookings];
}