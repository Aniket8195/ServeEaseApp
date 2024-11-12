import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Login/bloc/login_bloc.dart';
import '../Components/snackbar.dart';
import '../Theme/app_pallete.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSeeker = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSnackBar(
            "Logged In",
            context,
            Icons.done,
            AppPallete.primaryColor,
          );
          Navigator.pushReplacementNamed(
            context,
            state.isSeeker ? '/seekerHome' : '/providerHome',
          );
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppPallete.errorColor,
            ),
          );
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome Back',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppPallete.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        _buildCheckbox(),
                        const SizedBox(height: 32),
                        _buildLoginButton(context),
                        if (state is LoginLoading)
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        const SizedBox(height: 16),
                        _buildRegisterLink(context),
                      ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
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
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }

  Widget _buildCheckbox() {
    return Row(
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
        const Text('I am a Seeker', style: TextStyle(color: AppPallete.secondaryTextColor)),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            email: emailController.text,
            password: passwordController.text,
            isSeeker: isSeeker,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text('Login', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: AppPallete.secondaryTextColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: AppPallete.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}