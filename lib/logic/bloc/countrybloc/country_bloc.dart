import 'package:bloc/bloc.dart';
import 'package:country_app/data/repositories/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc({required this.countryRepository})
      : super(CountryInitialState()) {
    on<LoadCountryEvent>((event, emit) async {
      emit(CountryLoadingState());
      try {
        List<CountryModel> countryList = await countryRepository.getCountries();
        emit(
          CountryLoadedState(
            countryList: countryList,
            sortingStatus: 'Name',
            groupingStatus: 'Ungrouped',
          ),
        );
      } catch (error) {
        emit(CountryErrorState(error: error.toString()));
      }
    });
    on<ChangeGroupAndSortEvent>(
      (event, emit) {
        emit((state as CountryLoadedState).copyWith(
            groupingStatus: event.groupValue, sortingStatus: event.sortValue));
      },
    );
  }

  final CountryRepository countryRepository;
}
