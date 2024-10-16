part of 'seeker_bloc.dart';

@immutable
abstract class SeekerState extends Equatable{
  final int tabIndex;

  const SeekerState({this.tabIndex = 0});
  @override
  List<Object> get props => [ tabIndex ];
}

final class SeekerInitial extends SeekerState {
  const SeekerInitial({super.tabIndex});
}
