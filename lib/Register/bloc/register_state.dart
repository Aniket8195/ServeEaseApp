part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable{
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class CategoriesFetched extends RegisterState {
  final List<CategoryModel> categories;

  CategoriesFetched(this.categories);

  @override
  List<Object> get props => [categories];
}
class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);

  @override
  List<Object> get props => [message];
}
class RegistrationSuccess extends RegisterState {
  final String message;
  final bool isSeeker;

  RegistrationSuccess(this.message, this.isSeeker);

  @override
  List<Object> get props => [message];
}