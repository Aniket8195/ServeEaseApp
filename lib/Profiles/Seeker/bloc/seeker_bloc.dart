import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serve_ease/API/dio_instance.dart';
import 'package:serve_ease/Models/booking_model.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Profiles/Seeker/Repository/seeker_repo.dart';
import 'package:serve_ease/Splash/Repository/splash_repo.dart';

import '../../../Models/service_providers.dart';

part 'seeker_event.dart';
part 'seeker_state.dart';

class SeekerBloc extends Bloc<SeekerEvent, SeekerState> {
  SeekerRepo seekerRepo;
  SeekerBloc(this.seekerRepo) : super(const SeekerInitial(tabIndex: 0)) {
    on<SeekerEvent>((event, emit)async {
      if (event is TabChanged) {
        emit(SeekerInitial(tabIndex: event.tabIndex));

      } else if (event is FetchCategories) {
        await  _fetchCategories(emit);
      } else if (event is FetchBookings) {
        await  _fetchBookings(emit);
      }
    });


    on<CategorySelected> ((event, emit)async {
      String categroryProvidersUrl='http://localhost:8080/category/${event.category}';
      final response=await MainInstance().dio.get(categroryProvidersUrl);
      final List<dynamic> data = response.data['data'];
      List<ServiceProviderModel> serviceProviders = data.map((e) => ServiceProviderModel.fromJson(e)).toList();
      int userID=await SplashRepo().getId();
      emit(CategoryServiceProviders(serviceProviders: serviceProviders, tabIndex: 0,categoryID:
      event.category,userID: userID
      ));
    });
    Future<void> _addReview(AddReview event, Emitter<SeekerState> emit) async {
      try {
        await seekerRepo.addReview(event.bookingId, event.rating, event.comment, event.seekerReview, event.seekerId, event.providerId);
        emit(ReviewAdded(tabIndex: 0));
      } catch (error) {
        print(error.toString());
      }
    }
      on<AddReview>((event, emit) async {
        await _addReview(event, emit);
      });

    on<BookingEvent>((event, emit) async{
      final response = await MainInstance().dio.post('http://localhost:8080/booking/add', data: {
        'providerId': event.providerID,
        'seekerId': event.seekerID,
        'categoryId': event.categoryID,
        'bookingDate': event.dateTime.toIso8601String(),
      });
      if(response.statusCode==200){
        emit(BookingDone (tabIndex: 0));
      }else{
        print('Failed to book');
      }

    });
  }

  Future<void> _fetchCategories(Emitter<SeekerState> emit) async {
   try{
     final response = await MainInstance().dio.get('http://localhost:8080/category/all');
     final List<dynamic> data = response.data['data'];
     List<CategoryModel> categories = data.map((e) => CategoryModel.fromJson(e)).toList();
     emit(FetchedCategories(categories: categories, tabIndex: 0));
   }catch(e){
     print(e.toString());
     //emit(FetchCategoriesFailed(tabIndex: 0));
   }
  }

  Future<void> _fetchBookings(Emitter<SeekerState> emit) async {
    try{
      int userID=await SplashRepo().getId();
      String url='http://localhost:8080/booking/seeker/$userID';
      final response = await MainInstance().dio.get(url);
      final List<dynamic> data = response.data['data'];
      List<BookingModel> bookings = data.map((e) => BookingModel.fromJson(e)).toList();
      emit(BookingsFetched(bookings: bookings, tabIndex: 0));
    }catch(e){
      print(e.toString());
    }
  }

}