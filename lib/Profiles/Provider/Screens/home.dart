import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/provider_bloc.dart';

class HomeScreenProvider extends StatefulWidget {
  const HomeScreenProvider({super.key});

  @override
  State<HomeScreenProvider> createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc,ProviderState>(
        listener: (context,state){

        },
        builder: (context,state){
          return const Center(
            child: Text('Home Provider'),
          );
        }
    );
  }
}