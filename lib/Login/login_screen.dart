import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Login/bloc/login_bloc.dart';

import '../Components/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSeeker = false; // Checkbox state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {

        if(state is LoginSuccess){
          bool isSeeker = state.isSeeker;
          if(isSeeker){
            showSnackBar("logged In", context, Icons.done,Colors.green);
            Navigator.pushReplacementNamed(context,'/seekerHome');
          }else{
            showSnackBar("logged In", context, Icons.done,Colors.green);
            Navigator.pushReplacementNamed(context,'/providerHome');
          }

        }
        if(state is LoginFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Email TextField
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password TextField
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true, // Hide password input
                  ),

                  const SizedBox(height: 20),

                  // Checkbox to indicate if user is a seeker
                  Row(
                    children: [
                      Checkbox(
                        value: isSeeker,
                        onChanged: (bool? value) {
                          setState(() {
                            isSeeker = value ?? true;
                          });
                        },
                      ),
                      const Text('Are you a Seeker?'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Trigger login event through Bloc
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginButtonPressed(
                          email: emailController.text,
                          password: passwordController.text,
                          isSeeker: isSeeker,
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("Register", style: TextStyle(color: Colors.blue),)),
                  // Loading indicator (if the state is loading)
                  if (state is LoginLoading) const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
