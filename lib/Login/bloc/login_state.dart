part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isSeeker;

  LoginSuccess(this.isSeeker);

  @override
  List<Object> get props => [isSeeker];
}
class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}