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
              'Provider ID: ${booking.providerId}',
              style: const TextStyle(
                color: AppPallete.primaryTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Booking Date: ${booking.bookingDate.toLocal()}',
              style: const TextStyle(
                color: AppPallete.secondaryTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${_getBookingStatus(booking)}',
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

  // Helper method to get booking status (you might need to adjust this based on your model)
  String _getBookingStatus(BookingModel booking) {
    // Assuming you add a `status` property to BookingModel, you can return it here
    // For now, returning dummy data:
    return 'Pending'; // Change based on your logic
  }

  // Helper method to get status color
  Color _getStatusColor(BookingModel booking) {
    final status = _getBookingStatus(booking);
    if (status == 'Completed') {
      return AppPallete.successColor;
    } else if (status == 'Cancelled') {
      return AppPallete.errorColor;
    }
    return AppPallete.secondaryTextColor;
  }
}
