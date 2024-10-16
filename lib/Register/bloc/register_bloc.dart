import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../Repository/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo;

  RegisterBloc(this.registerRepo) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
