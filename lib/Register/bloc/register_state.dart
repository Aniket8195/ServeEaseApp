part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable{
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}
