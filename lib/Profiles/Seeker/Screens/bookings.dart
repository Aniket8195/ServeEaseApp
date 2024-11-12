import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/booking_model.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';
import 'package:serve_ease/Theme/app_pallete.dart';

class BookingsSeeker extends StatefulWidget {
  const BookingsSeeker({super.key});

  @override
  State<BookingsSeeker> createState() => _BookingsSeekerState();
}

class _BookingsSeekerState extends State<BookingsSeeker> {
  @override
  void initState() {
    super.initState();
    // Ensure the context is ready before accessing the bloc
    Future.microtask(() {
      BlocProvider.of<SeekerBloc>(context).add(FetchBookings());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeekerBloc, SeekerState>(
      listener: (context, state) {
        // Add any necessary listener logic here
      },
      builder: (context, state) {
        if (state is BookingsFetched) {
          return Scaffold(
            backgroundColor: AppPallete.backgroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Bookings',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppPallete.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.bookings.length,
                        itemBuilder: (context, index) {
                          final booking = state.bookings[index];
                          return _buildBookingCard(booking);
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

  Widget _buildBookingCard(BookingModel booking) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${booking.categoryName}',
              style: const TextStyle(
                color: AppPallete.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Booking Date: ${booking.bookingDate.toLocal()}',
              style: const TextStyle(
                color: AppPallete.secondaryTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${booking.status}',
              style: TextStyle(
                color: _getStatusColor(booking),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Color _getStatusColor(BookingModel booking) {
    final status = booking.status;
    if (status == 'COMPLETE') {
      return AppPallete.successColor;
    } else if (status == 'CANCELLED') {
      return AppPallete.errorColor;
    }
    return AppPallete.secondaryTextColor;
  }
}
