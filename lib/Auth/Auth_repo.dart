import 'package:serve_ease/Splash/Repository/splash_repo.dart';

import '../main.dart';

class AuthRepo{

  Future<void>logout()async{
    await SplashRepo().clearUserData();
    navigatorKey.currentState!.pushNamedAndRemoveUntil('/login', (route) => false);
  }
}