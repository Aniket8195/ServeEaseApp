part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class GetCategories extends RegisterEvent{
  @override
  List<Object> get props => [];
}
class RegisterProviderEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final bool isSeeker;
  final List<int> categories;
  RegisterProviderEvent({required this.name,required this.email,required this.password,required this.isSeeker,required this.categories});
  @override
  List<Object> get props => [ name,email, password, isSeeker, categories];
}
class RegisterSeekerEvent extends RegisterEvent {
  final String email;
  final String name;
  final String password;
  final bool isSeeker=true;

  RegisterSeekerEvent({required this.email,required this.name,required this.password});
  @override
  List<Object> get props => [ email,name, password];
}

