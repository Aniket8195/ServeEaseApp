import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/booking_model.dart';
import 'package:serve_ease/Profiles/Provider/bloc/provider_bloc.dart';
import 'package:serve_ease/Theme/app_pallete.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingsProvider extends StatefulWidget {
  const BookingsProvider({super.key});

  @override
  State<BookingsProvider> createState() => _BookingsProviderState();
}

class _BookingsProviderState extends State<BookingsProvider>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ProviderBloc>().add(FetchBookings());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderBloc, ProviderState>(
      listener: (context, state) {
        if (state is ProviderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
        if (state is BookingActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Action completed successfully')),
          );
          // Refresh bookings after action is performed
          context.read<ProviderBloc>().add(FetchBookings());
        }
        if(state is RatingActionSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Action completed successfully')),
          );
          context.read<ProviderBloc>().add(FetchBookings());

        }
      },
      builder: (context, state) {
        if (state is BookingsFetched) {
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
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Pending'),
                  Tab(text: 'Confirmed'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingList(state.pendingBookings, 'pending'),
                _buildBookingList(state.confirmedBookings, 'confirmed'),
                _buildBookingList(state.completedBookings, 'completed'),
              ],
            ),
          );
        }

        if (state is ProviderLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppPallete.primaryColor,
            ),
          );
        }

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

  Widget _buildBookingList(List<BookingModel> bookings, String status) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking, status);
      },
    );
  }

  Widget _buildBookingCard(BookingModel booking, String status) {
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
            _buildInfoRow('Category:', booking.categoryName),
            const SizedBox(height: 8),
            _buildInfoRow('Status:', booking.status),
            const SizedBox(height: 8),
            _buildInfoRow('Booking Date:', booking.bookingDate.toString()),
            const SizedBox(height: 16),
            if (status == 'pending') _buildPendingActions(booking.bookingId),
            if (status == 'confirmed') _buildConfirmedActions(booking.bookingId,booking.rating),
            if (status=='completed')_buildCompletedActions(booking.bookingId,booking.rating,booking),
          ],
        ),
      ),
    );
  }
 Widget _buildCompletedActions (int bookingId, double rating, BookingModel booking) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        rating==0?ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.primaryColor,
            textStyle: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Handle rating logic here
              showReviewAlert(context, booking);
          },
          child: const Text('Rate'),
        ): Text('Rating:$rating',style: TextStyle(color: AppPallete.primaryTextColor,fontWeight: FontWeight.bold),),
      ],
    );

 }

  void showReviewAlert(BuildContext parentContext, BookingModel booking) {
    double userRating = booking.rating ?? 0.0;
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Category: ${booking.categoryName}'),
              Text('Booking Date: ${booking.bookingDate}'),
              SizedBox(height: 20),
              Text('Rating:'),
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 10,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Enter your review',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String comment = commentController.text;
                // Save or submit the rating and comment
                print('Rating: $userRating, Comment: $comment');
               BlocProvider.of<ProviderBloc>(parentContext).add(AddReview(bookingId: booking.bookingId, rating: userRating, comment: comment, seekerReview: false, seekerId: booking.seekerId, providerId: booking.providerId));
                Navigator.of(dialogContext).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }


  Widget _buildPendingActions(int bookingId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.cancelButtonColor,
            textStyle: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Handle cancellation logic here
            context.read<ProviderBloc>().add(CancelBooking(bookingId: bookingId));
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
            context.read<ProviderBloc>().add(ConfirmBooking(bookingId: bookingId));
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildConfirmedActions(int bookingId, double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            // Handle completion logic here
            context.read<ProviderBloc>().add(CompleteBooking(bookingId: bookingId));
          },
          child: const Text('Completed'),
        ),
        // const SizedBox(width: 16),
        // rating==0?ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppPallete.primaryColor,
        //     textStyle: const TextStyle(color: Colors.white),
        //   ),
        //   onPressed: () {
        //     // Handle rating logic here
        //   },
        //   child: const Text('Rate'),
        // ): Text('Rating:$rating',style: TextStyle(color: AppPallete.primaryTextColor,fontWeight: FontWeight.bold),),
      ],
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
