import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/seeker_bloc.dart';

class ProfileSeeker extends StatefulWidget {
  const ProfileSeeker({super.key});

  @override
  State<ProfileSeeker> createState() => _ProfileSeekerState();
}

class _ProfileSeekerState extends State<ProfileSeeker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeekerBloc,SeekerState>(
        listener: (context,state){

        },
        builder: (context,state){
          return const Center(
            child: Text('Profile'),
          );
        }
    );
  }
}
