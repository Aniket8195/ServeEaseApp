import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';

class HomeSeeker extends StatefulWidget {
  const HomeSeeker({super.key});

  @override
  State<HomeSeeker> createState() => _HomeSeekerState();
}

class _HomeSeekerState extends State<HomeSeeker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeekerBloc,SeekerState>(
        listener: (context,state){

        },
        builder: (context,state){
          return const Center(
            child: Text('Home'),
          );
        }
    );
  }
}
