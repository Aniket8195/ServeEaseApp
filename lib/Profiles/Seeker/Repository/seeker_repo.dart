import 'package:serve_ease/API/dio_instance.dart';
import 'package:serve_ease/API/api_url.dart';
class SeekerRepo{
      Future<void>addReview(int bookingId,double rating,String comment,bool seekerReview, int seekerId,int providerId)async{
          String url='$instance/review/add';
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
       String url='$instance/payment/add';
       await MainInstance().dio.post(url,data: {
           'amount':amount,
            'bookingId':bookingID,
       });

    }
}