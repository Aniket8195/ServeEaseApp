import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart' as seeker_bloc;
import 'package:serve_ease/Theme/app_pallete.dart';

import '../bloc/seeker_bloc.dart';

class HomeSeeker extends StatefulWidget {
  const HomeSeeker({super.key});

  @override
  State<HomeSeeker> createState() => _HomeSeekerState();
}

class _HomeSeekerState extends State<HomeSeeker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<seeker_bloc.SeekerBloc, seeker_bloc.SeekerState>(
      listener: (context, state) {
        // Add any necessary listener logic here
      },
      builder: (context, state) {
        if (state is FetchedCategories) {
          return Scaffold(
            backgroundColor: AppPallete.backgroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Services',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppPallete.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return _buildCategoryCard(category);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: AppPallete.primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        // Navigate to the service details screen or handle the category selection
        Navigator.pushNamed(context, '/service-details', arguments: category);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.category,
                color: AppPallete.primaryColor,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(
                  color: AppPallete.primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}