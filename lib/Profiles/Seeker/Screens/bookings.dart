import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_ease/Models/booking_model.dart';
import 'package:serve_ease/Profiles/Seeker/bloc/seeker_bloc.dart';
import 'package:serve_ease/Theme/app_pallete.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        if(state is ReviewAdded){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review added successfully'),
            ),
          );
          context.read<SeekerBloc>().add(FetchBookings());

        }
        if(state is PaymentDone){

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment done successfully'),
            ),
          );
          context.read<SeekerBloc>().add(FetchBookings());
        }
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
            const SizedBox(height: 8),
            booking.status == 'COMPLETED'
                ? Row(
              children: [
                booking.rating == 0
                    ? ElevatedButton(
                  onPressed: () {
                    showReviewAlert(context, booking);
                  },
                  child: Text("Rate"),
                )
                    : Text(
                  "Rating: ${booking.rating}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
                : Container(),
            const SizedBox(height: 8),
            booking.status == 'COMPLETED' && booking.paid==false
                ? Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    //BlocProvider.of<ProviderBloc>(context).add(CompleteBooking(bookingId: booking.bookingId));
                   // BlocProvider.of<SeekerBloc>(context).add(CompletePayment(bookingId: booking.bookingId));
                    showPaymentAlert(context, booking);
                  },
                  child: Text("Pay"),
                ),
              ],
            )
                : Container(),

            const SizedBox(height: 8),
            booking.paid==true
                ? Text(
              'Paid',
              style: TextStyle(
                color: AppPallete.successColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
  void showPaymentAlert(BuildContext parentContext, BookingModel booking) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Category: ${booking.categoryName}'),
              Text('Booking Date: ${booking.bookingDate}'),
              SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  hintText: 'Amount to Pay',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final enteredAmount = double.tryParse(amountController.text);
                  if (enteredAmount != null && enteredAmount > 0) {

                    BlocProvider.of<SeekerBloc>(parentContext).add(
                      CompletePayment(bookingID: booking.bookingId, amount: enteredAmount),
                    );
                    Navigator.of(dialogContext).pop();
                  } else {

                    ScaffoldMessenger.of(parentContext).showSnackBar(
                      SnackBar(content: Text('Please enter a valid amount')),
                    );
                  }
                },
                child: Text('Pay'),
              ),
            ],
          ),
        );
      },
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

                //BlocProvider.of<ProviderBloc>(parentContext).add(AddReview(bookingId: booking.bookingId, rating: userRating, comment: comment, seekerReview: false, seekerId: booking.seekerId, providerId: booking.providerId));
                BlocProvider.of<SeekerBloc>(parentContext).add(AddReview(bookingId: booking.bookingId, rating: userRating, comment: comment, seekerReview: true, seekerId: booking.seekerId, providerId: booking.providerId));
                Navigator.of(dialogContext).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
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
