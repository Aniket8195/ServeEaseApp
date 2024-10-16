import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Auth/Auth_repo.dart';
import 'package:serve_ease/Components/snackbar.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';

class SeekerHome extends StatefulWidget {
  const SeekerHome({super.key});

  @override
  State<SeekerHome> createState() => _SeekerHomeState();
}

class _SeekerHomeState extends State<SeekerHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeekerBloc,SeekerState>(
      listener: (context, state) {

      }
      ,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Seeker Home'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showSnackBar("logged Out", context, Icons.done,Colors.green);
                  AuthRepo().logout();
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Seeker Home',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
