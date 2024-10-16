import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Login/Repository/login_repo.dart';
import 'package:serve_ease/Login/bloc/login_bloc.dart';
import 'package:serve_ease/Profiles/Provider/Repository/provider_repo.dart';
import 'package:serve_ease/Profiles/Provider/Screens/provider.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';
import 'package:serve_ease/Profiles/Seeker/Repository/seeker_repo.dart';
import 'package:serve_ease/Profiles/Seeker/Screens/seeker.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';
import 'package:serve_ease/Register/Repository/register_repo.dart';
import 'package:serve_ease/Splash/Repository/splash_repo.dart';

import '../Login/login_screen.dart';
import '../Register/bloc/register_bloc.dart';
import '../Register/register_screen.dart';
import '../Splash/bloc/splash_bloc.dart';
import '../Splash/splash_screen.dart';

class AppRouter{
    Route generateRoute(RouteSettings settings){
        switch(settings.name){
            case '/':
                return MaterialPageRoute(
                    builder:(_)=>RepositoryProvider(
                        create: (context)=>SplashRepo(),
                        child: BlocProvider(
                            create: (context)=>SplashBloc(context.read<SplashRepo>())..add(AuthCheck()),
                            child: const SplashScreen(),
                        ),
                    )
                );

            case '/login':
                return
                    MaterialPageRoute(
                        builder:(_)=>RepositoryProvider(
                            create: (context)=>LoginRepo(),
                            child: BlocProvider(
                                create: (context)=>LoginBloc(context.read<LoginRepo>()),
                                child: const LoginScreen()
                            ),
                        )

                    );
            case '/register':
                return MaterialPageRoute(
                    builder: (_)=> RepositoryProvider(create:
                    (context)=>RegisterRepo(),
                    child: BlocProvider(create: (context)=>RegisterBloc(context.read<RegisterRepo>(),

                    )..add(GetCategories()),
                      child: const RegisterScreen(),
                    )
                    )
                );

          case '/seekerHome':
                return MaterialPageRoute(
                    builder: (_)=> RepositoryProvider(create:
                    (context)=>SeekerRepo(),
                    child: BlocProvider(create: (context)=>SeekerBloc(context.read<SeekerRepo>()),
                      child: const SeekerHome(),
                    ),
                    )
                );

            case '/providerHome':
                return MaterialPageRoute(
                    builder: (_)=> RepositoryProvider(create:
                    (context)=>ProviderRepo(),
                    child: BlocProvider(create: (context)=>ProviderBloc(context.read<ProviderRepo>()),
                      child: const ProviderHome(),
                    )
                    )
                );
            default:
                return
                    MaterialPageRoute(
                        builder:(_)=>RepositoryProvider(
                            create: (context)=>LoginRepo(),
                            child: BlocProvider(
                                create: (context)=>LoginBloc(context.read<LoginRepo>()),
                                child: const LoginScreen()
                            ),
                        )

                    );
        }
    }

}