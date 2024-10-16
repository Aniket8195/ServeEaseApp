import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


import '../../Models/category_model.dart';
import '../Repository/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo;

  RegisterBloc(this.registerRepo) : super(RegisterInitial()) {
    on<GetCategories>((event, emit)async {
      emit(RegisterLoading());
      try {
        final List<CategoryModel>categories = await registerRepo.getCategories();
        emit(CategoriesFetched(categories));
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });

    on<RegisterProviderEvent>((event, emit)async {
      emit(RegisterLoading());
      try {
        // Register user
        bool isSeeker = event.isSeeker;

        await registerRepo.registerProvider(event.email, event.name, event.password, event.categories);


        emit(RegistrationSuccess('User registered successfully',isSeeker),);
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });

    on<RegisterSeekerEvent>((event, emit)async {
      emit(RegisterLoading());
      try {
        // Register user
        bool isSeeker = event.isSeeker;

        await registerRepo.registerSeeker(event.email, event.name, event.password);


        emit(RegistrationSuccess('User registered successfully',isSeeker),);
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
