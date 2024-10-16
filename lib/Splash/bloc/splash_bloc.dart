import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:serve_ease/Splash/Repository/splash_repo.dart';
import 'package:equatable/equatable.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashRepo splashRepo;

  SplashBloc(this.splashRepo) : super(SplashInitial()) {
    on<AuthCheck>((event, emit) async{
      bool isAuthenticated=await splashRepo.isUserLoggedIn();
      if(isAuthenticated){
        String role=await splashRepo.getRole();
        emit(Authenticated(role));
      }else{
          emit(Unauthenticated());
      }
    });
  }
}
