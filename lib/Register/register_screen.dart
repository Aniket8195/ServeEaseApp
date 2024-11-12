import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Register/bloc/register_bloc.dart';
import 'package:serve_ease/Theme/app_pallete.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSeeker = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<CategoryModel> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppPallete.primaryColor.withOpacity(0.1),
                  AppPallete.accentColor.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppPallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          _buildTextField(emailController, 'Email', Icons.email),
                          const SizedBox(height: 16),
                          _buildTextField(nameController, 'Name', Icons.person),
                          const SizedBox(height: 16),
                          _buildTextField(passwordController, 'Password', Icons.lock, isPassword: true),
                          const SizedBox(height: 24),
                          _buildSeekerCheckbox(),
                          if (!isSeeker && state is CategoriesFetched) ...[
                            const SizedBox(height: 24),
                            _buildCategorySelection(state.categories),
                          ],
                          const SizedBox(height: 32),
                          _buildRegisterButton(),
                          const SizedBox(height: 16),
                          _buildLoginLink(),
                          if (state is RegisterLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppPallete.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPallete.primaryColor, width: 2),
        ),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSeekerCheckbox() {
    return Container(
      decoration: BoxDecoration(
        color: AppPallete.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPallete.borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: isSeeker,
            onChanged: (bool? value) {
              setState(() {
                isSeeker = value ?? false;
              });
            },
            activeColor: AppPallete.primaryColor,
          ),
          const Expanded(
            child: Text(
              'I am looking for services (Seeker)',
              style: TextStyle(color: AppPallete.secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelection(List<CategoryModel> categories) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your service categories:',
              style: TextStyle(
                color: AppPallete.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...categories.map((category) => CheckboxListTile(
              title: Text(category.name, style: const TextStyle(color: AppPallete.secondaryTextColor)),
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
              activeColor: AppPallete.primaryColor,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _handleRegistration,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Register', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?", style: TextStyle(color: AppPallete.secondaryTextColor)),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          child: const Text(
            'Log In',
            style: TextStyle(
              color: AppPallete.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRegistration() {
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
          categories: selectedCategories.map((category) => category.id).toList(),
        ),
      );
    }
  }
}