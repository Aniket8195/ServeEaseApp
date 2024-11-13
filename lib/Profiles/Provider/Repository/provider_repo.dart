import '../../../API/dio_instance.dart';

class ProviderRepo{
    Future<void>cancelBooking(int id)async{
        String url='http://localhost:8080/booking/cancel/$id';
        await MainInstance().dio.put(url);
    }
    Future<void>confirmBooking(int id)async{
        String url='http://localhost:8080/booking/confirm/$id';
        await MainInstance().dio.put(url);
    }
    Future<void>completeBooking(int id)async{
        String url='http://localhost:8080/booking/complete/$id';
        await MainInstance().dio.put(url);
    }
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
}