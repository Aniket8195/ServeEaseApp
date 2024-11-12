import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';
import 'package:serve_ease/Theme/app_pallete.dart';

class BookingsProvider extends StatefulWidget {
  const BookingsProvider({super.key});

  @override
  State<BookingsProvider> createState() => _BookingsProviderState();
}

class _BookingsProviderState extends State<BookingsProvider> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching bookings when the screen is first loaded
    context.read<ProviderBloc>().add(FetchBookings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc, ProviderState>(
      listener: (context, state) {
        // Add any necessary listener logic here
      },
      builder: (context, state) {
        if (state is BookingsFetched) {
          // If bookings are fetched successfully, show them
          return Scaffold(
            backgroundColor: AppPallete.backgroundColor,
            appBar: AppBar(
              title: const Text(
                'Bookings',
                style: TextStyle(
                  color: AppPallete.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppPallete.surfaceColor,
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = state.bookings[index];
                    return _buildBookingCard(booking as Map<String, dynamic>);
                  },
                ),
              ),
            ),
          );
        }

        // If the state is loading, show a loading spinner
        if (state is ProviderLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppPallete.primaryColor,
            ),
          );
        }

        // Show error state if bookings cannot be fetched
        if (state is ProviderError) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: TextStyle(
                color: AppPallete.errorColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }

        return const Center(
          child: Text('No Data Available'),
        );
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final providerId = booking['providerId'];
    final seekerId = booking['seekerId'];
    final categoryId = booking['categoryId'];
    final bookingDate = booking['bookingDate']; // Ensure correct format is maintained

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Provider ID:', providerId.toString()),
            const SizedBox(height: 8),
            _buildInfoRow('Seeker ID:', seekerId.toString()),
            const SizedBox(height: 8),
            _buildInfoRow('Category ID:', categoryId.toString()),
            const SizedBox(height: 8),
            _buildInfoRow('Booking Date:', bookingDate),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.cancelButtonColor,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Handle cancellation logic here
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.confirmButtonColor,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Handle confirmation logic here
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppPallete.primaryTextColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: AppPallete.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
