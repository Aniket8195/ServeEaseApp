import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serve_ease/API/dio_instance.dart';
import 'package:serve_ease/Models/booking_model.dart';
import 'package:serve_ease/Models/category_model.dart';
import 'package:serve_ease/Profiles/Seeker/Repository/seeker_repo.dart';

part 'seeker_event.dart';
part 'seeker_state.dart';

class SeekerBloc extends Bloc<SeekerEvent, SeekerState> {
  SeekerRepo seekerRepo;
  SeekerBloc(this.seekerRepo) : super(const SeekerInitial(tabIndex: 0)) {
    on<SeekerEvent>((event, emit) {
      if (event is TabChanged) {
        emit(SeekerInitial(tabIndex: event.tabIndex));
      } else if (event is FetchCategories) {
        _fetchCategories(emit);
      } else if (event is FetchBookings) {
        _fetchBookings(emit);
      }
    });
  }

  Future<void> _fetchCategories(Emitter<SeekerState> emit) async {
    final response = await MainInstance().dio.get('http://localhost:8080/category/all');
    final List<dynamic> data = response.data['data'];
    List<CategoryModel> categories = data.map((e) => CategoryModel.fromJson(e)).toList();
    emit(FetchedCategories(categories: categories, tabIndex: 0));
  }

  Future<void> _fetchBookings(Emitter<SeekerState> emit) async {
    final response = await MainInstance().dio.get('http://localhost:8080/booking/seeker');
    final List<dynamic> data = response.data['data'];
    List<BookingModel> bookings = data.map((e) => BookingModel.fromJson(e)).toList();
    emit(BookingsFetched(bookings: bookings, tabIndex: 0));
  }
}