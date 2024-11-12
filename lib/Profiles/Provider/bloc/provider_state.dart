part of 'provider_bloc.dart';

@immutable
abstract class ProviderState extends Equatable {
  final int tabIndex;

  const ProviderState({this.tabIndex = 0});

  @override
  List<Object> get props => [tabIndex];
}

// Initial state when the provider tab index is set for the first time
class ProviderInitial extends ProviderState {
  const ProviderInitial({super.tabIndex});
}

// Loading state when fetching data (e.g., bookings)
class ProviderLoading extends ProviderState {
  const ProviderLoading({super.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

// Success state when data (bookings) is fetched successfully
class BookingsFetched extends ProviderState {
  final List<dynamic> bookings;

  const BookingsFetched({required this.bookings, super.tabIndex});

  @override
  List<Object> get props => [tabIndex, bookings];
}

// Error state when something goes wrong during fetching data
class ProviderError extends ProviderState {
  final String errorMessage;

  const ProviderError({required this.errorMessage, super.tabIndex});

  @override
  List<Object> get props => [tabIndex, errorMessage];
}
