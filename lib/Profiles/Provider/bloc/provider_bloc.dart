import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../Repository/provider_repo.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderRepo providerRepo;
  ProviderBloc(this.providerRepo) : super(ProviderInitial()) {
    on<ProviderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
