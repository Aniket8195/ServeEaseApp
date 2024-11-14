import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serve_ease/Splash/Repository/splash_repo.dart';
import '../../../API/dio_instance.dart';
import '../../../Models/booking_model.dart';
import '../../../Models/profile_model.dart';
import '../Repository/provider_repo.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final ProviderRepo providerRepo;

  ProviderBloc(this.providerRepo) : super(const ProviderInitial(tabIndex: 0)) {
    // Handling events
    on<TabChanged>(_onTabChanged);
    on<FetchBookings>(_onFetchBookings);
    on<CancelBooking> (_onCancelBooking);
    on<ConfirmBooking>(_onConfirmBooking);
    on<CompleteBooking>(_onCompleteBooking);
    on<AddReview>(_onAddReview);
    on<FetchProfile>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProviderState> emit) async {
    emit(const ProviderLoading()); // Emit loading state while fetching profile

    try {
      print("fetching profile");
      int userID=await SplashRepo().getId();
      final response = await MainInstance().dio.get('http://localhost:8080/user/profile/$userID');
      final data = response.data['user'];
      UserProfile userProfile = UserProfile.fromJson(data);
      emit(ProfileFetched(userProfile: userProfile));
    } catch (error) {
      // Emit error state if fetching fails
      emit(ProviderError(errorMessage: error.toString()));
    }
  }

  Future<void> _onAddReview(AddReview event, Emitter<ProviderState> emit) async {
    try {
      await providerRepo.addReview(event.bookingId, event.rating, event.comment, event.seekerReview, event.seekerId, event.providerId);
      emit(const RatingActionSuccess());
    } catch (error) {
      emit(ProviderError(errorMessage: error.toString()));
    }
  }
  Future<void> _onCancelBooking(CancelBooking event, Emitter<ProviderState> emit) async {
    try {
      await providerRepo.cancelBooking(event.bookingId);
      emit(const BookingActionSuccess());
    } catch (error) {
      emit(ProviderError(errorMessage: error.toString()));
    }
  }
  Future<void> _onConfirmBooking(ConfirmBooking event, Emitter<ProviderState> emit) async {
    try {
      await providerRepo.confirmBooking(event.bookingId);
      emit(const BookingActionSuccess());
    } catch (error) {
      emit(ProviderError(errorMessage: error.toString()));
    }
  }
  Future<void> _onCompleteBooking(CompleteBooking event, Emitter<ProviderState> emit) async {
    try {
      await providerRepo.completeBooking(event.bookingId);
      emit(const BookingActionSuccess());
    } catch (error) {
      emit(ProviderError(errorMessage: error.toString()));
    }
  }

  void _onTabChanged(TabChanged event, Emitter<ProviderState> emit) {
    emit(ProviderInitial(tabIndex: event.tabIndex));
  }

  Future<void> _onFetchBookings(FetchBookings event, Emitter<ProviderState> emit) async {
    emit(const ProviderLoading()); // Emit loading state while fetching bookings

    try {
      int id=await SplashRepo().getId();
      String urlB='http://localhost:8080/booking/provider/$id';
      final response = await MainInstance().dio.get(urlB);
      final List<dynamic> data = response.data['data'];
      List<BookingModel> bookings = data.map((e) => BookingModel.fromJson(e)).toList();
      List<BookingModel>pendingBookings=bookings.where((element) => element.status=='PENDING').toList();
      List<BookingModel>confirmedBookings=bookings.where((element) => element.status=='CONFIRMED').toList();
      List<BookingModel>completedBookings=bookings.where((element) => element.status=='COMPLETED').toList();
      emit(BookingsFetched(bookings: bookings, pendingBookings: pendingBookings, confirmedBookings: confirmedBookings, completedBookings: completedBookings));
    } catch (error) {
      // Emit error state if fetching fails
      emit(ProviderError(errorMessage: error.toString()));
    }
  }
}
