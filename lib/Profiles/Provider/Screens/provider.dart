import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';

import '../../../Auth/Auth_repo.dart';
import '../../../Components/snackbar.dart';
import '../constants.dart';

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
      return Scaffold(
        appBar: AppBar(
          title: const Text('Provider Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showSnackBar("logged Out", context, Icons.done,Colors.green);
                AuthRepo().logout();
              },
            ),
          ],
        ),
        body: Center(
          child: bottomNavScreens[state.tabIndex],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: state.tabIndex,
          onDestinationSelected: (index){
            context.read<ProviderBloc>().add(TabChanged(tabIndex: index));
          },
          destinations: bottomNav,
        ),
      );

      }

    );
  }
}
