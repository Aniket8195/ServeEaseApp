import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../Repository/seeker_repo.dart';

part 'seeker_event.dart';
part 'seeker_state.dart';

class SeekerBloc extends Bloc<SeekerEvent, SeekerState> {
  SeekerRepo seekerRepo;
  SeekerBloc(this.seekerRepo) : super(SeekerInitial()) {
    on<SeekerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
