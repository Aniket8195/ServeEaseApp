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
