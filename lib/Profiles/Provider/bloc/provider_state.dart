part of 'provider_bloc.dart';

@immutable
abstract class ProviderState extends Equatable{

  @override
  List<Object> get props => [];
}

final class ProviderInitial extends ProviderState {}
