import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart' as seeker_bloc;
import 'package:serve_ease/Splash/Repository/splash_repo.dart';
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
        if(state is seeker_bloc.BookingDone){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking Successful')),
          );
        }
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
        if(state is CategoryServiceProviders){
          final serviceProviders = state.serviceProviders;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Service Providers'),
              backgroundColor: Colors.deepPurple,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<seeker_bloc.SeekerBloc>(context).add(FetchCategories());
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: serviceProviders.length,
                itemBuilder: (context, index) {
                  final provider = serviceProviders[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Text(
                          provider.name[0].toUpperCase(), // Show first letter of name
                          style: const TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      title: Text(
                        provider.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email: ${provider.email}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                provider.rating.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Booking for ${provider.name}')),
                          // );
                          showAlert(this.context, provider.userId, state.userID, state.categoryID);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Book Now'),
                      ),
                    ),
                  );
                },
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


  showAlert(BuildContext context, int providerId, int seekerId, int categoryId) async {
    // Variables to store selected date and time
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // Show the date picker
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // If a date was selected, show the time picker
    if (selectedDate != null) {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
    }

    // If both date and time are selected, show the confirmation dialog
    if (selectedDate != null && selectedTime != null) {
      final dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      //final formattedDate = dateTime.toUtc().toIso8601String();
      BlocProvider.of<seeker_bloc.SeekerBloc>(context).add(seeker_bloc.BookingEvent(
        providerID: providerId,
        seekerID: seekerId,
        categoryID: categoryId,
        dateTime: dateTime,
      ));

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selected Date and Time'),
          content: Text('You selected: ${dateTime.toString()}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If the user didn't select both date and time
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('You must select both a date and a time.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  Widget _buildCategoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<seeker_bloc.SeekerBloc>(context).add(seeker_bloc.CategorySelected(
          category: category.id,
        ));
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