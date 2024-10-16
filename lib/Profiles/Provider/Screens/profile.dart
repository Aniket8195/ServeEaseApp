import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/provider_bloc.dart';

class ProfileProvider extends StatefulWidget {
  const ProfileProvider({super.key});

  @override
  State<ProfileProvider> createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc,ProviderState>(
        listener: (context,state){

        },
        builder: (context,state){
          return const Center(
            child: Text('Profile Provider'),
          );
        }
    );
  }
}
