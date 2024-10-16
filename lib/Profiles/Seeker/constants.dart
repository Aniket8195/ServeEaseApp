
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Seeker/Repository/seeker_repo.dart';
import 'package:serve_ease/Profiles/Seeker/Screens/bookings.dart';
import 'package:serve_ease/Profiles/Seeker/Screens/home.dart';
import 'package:serve_ease/Profiles/Seeker/Screens/profile.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';


List<NavigationDestination> bottomNav = const <NavigationDestination>[
  NavigationDestination(
    label: 'Home',
    icon: Icon(Icons.home),
  ),
  NavigationDestination(
    label: 'Bookings',
    icon: Icon(Icons.book),
  ),
  NavigationDestination(
    label: 'Profile',
    icon: Icon(Icons.person),
  ),
];

List<Widget> bottomNavScreens = <Widget>[
  RepositoryProvider(
    create: (context) => SeekerRepo(),
    child: BlocProvider(
      create: (context) => SeekerBloc(context.read<SeekerRepo>()),
      child: const HomeSeeker(),
    ),
  ),
  RepositoryProvider(
    create: (context) => SeekerRepo(),
    child: BlocProvider(
      create: (context) => SeekerBloc(context.read<SeekerRepo>()),
      child: const BookingsSeeker(),
    ),
  ),
  RepositoryProvider(
    create: (context) => SeekerRepo(),
    child: BlocProvider(
      create: (context) => SeekerBloc(context.read<SeekerRepo>()),
      child: const ProfileSeeker(),
    ),
  ),
];