
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Provider/Repository/provider_repo.dart';
import 'package:serve_ease/Profiles/Provider/Screens/bookings.dart';
import 'package:serve_ease/Profiles/Provider/Screens/home.dart';
import 'package:serve_ease/Profiles/Provider/Screens/profile.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';

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
    create: (context) => ProviderRepo(),
    child: BlocProvider(
      create: (context) => ProviderBloc(context.read<ProviderRepo>()),
      child: const HomeScreenProvider(),
    ),
  ),
  RepositoryProvider(
    create: (context) => ProviderRepo(),
    child: BlocProvider(
      create: (context) => ProviderBloc(context.read<ProviderRepo>())..add(FetchBookings()),
      child: const BookingsProvider(),
    ),
  ),
  RepositoryProvider(
    create: (context) => ProviderRepo(),
    child: BlocProvider(
      create: (context) => ProviderBloc(context.read<ProviderRepo>()),
      child: const ProfileProvider(),
    ),
  ),
];