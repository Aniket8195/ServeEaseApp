part of 'provider_bloc.dart';

@immutable
abstract class ProviderState extends Equatable{
  final int tabIndex;

  const ProviderState({this.tabIndex = 0});

  @override
  List<Object> get props => [ tabIndex ];
}

final class ProviderInitial extends ProviderState {
  const ProviderInitial({super.tabIndex});
}
