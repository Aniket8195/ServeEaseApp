part of 'provider_bloc.dart';

@immutable
abstract class ProviderEvent extends Equatable{

  @override
  List<Object> get props => [];
}
class TabChanged extends ProviderEvent {
  final int tabIndex;
  TabChanged({required this.tabIndex});
  @override
  List<Object> get props => [tabIndex];
}