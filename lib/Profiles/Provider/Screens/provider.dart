import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';

class ProviderHome extends StatefulWidget {
  const ProviderHome({super.key});

  @override
  State<ProviderHome> createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc,ProviderState>(
    listener: (context,state){

    },
    builder: (context,state){
          body: return Center(
            child: Text('Provider Home'),
          );

      }

    );
  }
}
