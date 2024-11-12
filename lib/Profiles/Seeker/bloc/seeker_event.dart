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