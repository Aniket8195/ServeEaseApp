import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../API/dio_instance.dart';
import '../../../Models/booking_model.dart';
import '../Repository/provider_repo.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  final ProviderRepo providerRepo;

  ProviderBloc(this.providerRepo) : super(const ProviderInitial(tabIndex: 0)) {
    // Handling events
    on<TabChanged>(_onTabChanged);
    on<FetchBookings>(_onFetchBookings);
  }

  void _onTabChanged(TabChanged event, Emitter<ProviderState> emit) {
    emit(ProviderInitial(tabIndex: event.tabIndex));
  }

  Future<void> _onFetchBookings(FetchBookings event, Emitter<ProviderState> emit) async {
    emit(const ProviderLoading()); // Emit loading state while fetching bookings

    try {
      final response = await MainInstance().dio.get('http://localhost:8080/booking/seeker');
      final List<dynamic> data = response.data['data'];
      List<BookingModel> bookings = data.map((e) => BookingModel.fromJson(e)).toList();

      // Emit success state with the fetched bookings
      emit(BookingsFetched(bookings: bookings));
    } catch (error) {
      // Emit error state if fetching fails
      emit(ProviderError(errorMessage: error.toString()));
    }
  }
}
