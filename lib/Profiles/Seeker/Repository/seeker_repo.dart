import 'package:serve_ease/API/dio_instance.dart';

class SeekerRepo{
      Future<void>addReview(int bookingId,double rating,String comment,bool seekerReview, int seekerId,int providerId)async{
          String url='http://localhost:8080/review/add';
          await MainInstance().dio.post(url,data: {
              'seekerId':seekerId,
              'providerId':providerId,
              'rating':rating,
              'comments':comment,
              'bookingId':bookingId,
              'seekerReview':seekerReview
          });
      }

   Future<void>completePayment(int bookingID, double amount)async{
       String url='http://localhost:8080/payment/add';
       await MainInstance().dio.post(url,data: {
           'amount':amount,
            'bookingId':bookingID,
       });

    }
}