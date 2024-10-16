import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/seeker_bloc.dart';

class BookingsSeeker extends StatefulWidget {
  const BookingsSeeker({super.key});

  @override
  State<BookingsSeeker> createState() => _BookingsSeekerState();
}

class _BookingsSeekerState extends State<BookingsSeeker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeekerBloc,SeekerState>(
        listener: (context,state){

        },
        builder: (context,state){
          return const Center(
            child: Text('Bookings'),
          );
        }
    );
  }
}
