import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serve_ease/Login/Repository/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo loginRepo;
  LoginBloc(this.loginRepo) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit)async {
      emit(LoginLoading());
      try {
        bool isSeeker=event.isSeeker;
        if(isSeeker){
          await loginRepo.loginSeeker(event.email, event.password);
          emit(LoginSuccess(isSeeker));
        }else{
          await loginRepo.loginProvider(event.email, event.password);
          emit(LoginSuccess(isSeeker));
        }

      } catch (e) {
        emit(LoginFailure(e.toString()));
      }


    });
  }


}
