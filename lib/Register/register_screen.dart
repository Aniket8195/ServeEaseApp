import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Register/bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSeeker = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<CategoryModel> selectedCategories = [];
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc,RegisterState>(

      listener: (context, state) {
       if(state is RegistrationSuccess){

            Navigator.pushReplacementNamed(context,'/login');

       }
      },
      builder: (context, state) {
        if(state is RegisterLoading){
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        if(state is CategoriesFetched){
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

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
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

                    // Category Dropdown
                    if (isSeeker == false)
                      Column(
                        children: state.categories.map((CategoryModel category) {
                          return CheckboxListTile(
                            title: Text(category.name),
                            value: selectedCategories.contains(category),
                            onChanged: (bool? isSelected) {
                              setState(() {
                                if (isSelected == true) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (isSeeker) {
                          BlocProvider.of<RegisterBloc>(context).add(
                            RegisterSeekerEvent(
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text,
                            ),
                          );
                        } else {
                          BlocProvider.of<RegisterBloc>(context).add(
                            RegisterProviderEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              isSeeker: isSeeker,
                              categories: selectedCategories.map((CategoryModel category) => category.id).toList(),
                            ),
                          );
                        }
                      },

                      child: const Text('Register'),
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.blue),)),
                    // Loading indicator (if the state is loading)
                    if (state is RegisterLoading) const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        }
        if(state is RegisterFailure){
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text('Register Failure'),
                  ElevatedButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, '/register');
                  }, child: const Text("Try Again"))
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      }
    );
  }
}
