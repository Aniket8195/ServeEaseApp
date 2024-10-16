part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final bool isSeeker;

  LoginButtonPressed({
    required this.email,
    required this.password,
    required this.isSeeker,
  });

  @override
  List<Object> get props => [email, password, isSeeker];
}
