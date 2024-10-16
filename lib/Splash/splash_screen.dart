import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if(state is Authenticated){
          if(state.role=='SEEKER'){
            Navigator.pushReplacementNamed(context, '/seekerHome');
          }else{
            Navigator.pushReplacementNamed(context, '/providerHome');
          }

        }
        if(state is Unauthenticated){
          Navigator.pushReplacementNamed(context, '/login');
        }

    },
      builder: (context, state) {
        return const Scaffold(
          body:

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      }
    );
  }
}
