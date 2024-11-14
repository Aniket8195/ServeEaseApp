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
class CategoryServiceProviders extends SeekerState {
  final int categoryID;
  final List<ServiceProviderModel> serviceProviders;
  final int userID;

  const CategoryServiceProviders({required this.serviceProviders, required super.tabIndex, required this.categoryID, required this.userID});

  @override
  List<Object> get props => [tabIndex, serviceProviders, categoryID, userID];
}
class BookingDone extends SeekerState {
  const BookingDone({required super.tabIndex});
}
class ReviewAdded extends SeekerState {
  const ReviewAdded({required super.tabIndex});
}
class ProfileFetched extends SeekerState {
  final UserProfile userProfile;

  const ProfileFetched({required this.userProfile, required super.tabIndex});

  @override
  List<Object> get props => [tabIndex, userProfile];
}