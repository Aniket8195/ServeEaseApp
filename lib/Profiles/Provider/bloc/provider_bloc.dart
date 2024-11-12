import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../Models/category_model.dart';
import '../Repository/provider_repo.dart';

part 'provider_event.dart';
part 'provider_state.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderRepo providerRepo;
  ProviderBloc(this.providerRepo) : super(const ProviderInitial(tabIndex: 0)) {
    on<ProviderEvent>((event, emit) {
      // TODO: implement event handler
      if (event is TabChanged) {
        emit(ProviderInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
