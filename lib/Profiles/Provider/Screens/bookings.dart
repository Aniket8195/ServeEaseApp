import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';

class BookingsProvider extends StatefulWidget {
  const BookingsProvider({super.key});

  @override
  State<BookingsProvider> createState() => _BookingsProviderState();
}

class _BookingsProviderState extends State<BookingsProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc,ProviderState>(
      listener: (context,state){

      },
      builder: (context,state){
        return const Center(
          child: Text('Bookings Provider'),
        );
      }
    );
  }
}
