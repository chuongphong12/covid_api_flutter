import 'package:bloc/bloc.dart';
import 'package:covid_api_flutter/models/country_model.dart';
import 'package:covid_api_flutter/models/failure_model.dart';
import 'package:covid_api_flutter/repository/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final ApiRepository apiRepository;

  final List<Country> listCountry = [];
  Country? country;

  CountryBloc({required this.apiRepository}) : super(CountryInitial()) {
    on<FetchAllCountry>((event, emit) async {
      emit(CountryLoading());
      try {
        final response = await apiRepository.getAllCountry();
        listCountry.clear();
        emit(CountryLoaded(countries: response));
        listCountry.addAll(response);
      } catch (e) {
        emit(CountryError(failure: Failure(message: e.toString(), code: '')));
      }
    });
    on<ChangeCountry>((event, emit) {
      emit(CountrySelected(country: event.country!));
      country = event.country;
      emit(CountryLoaded(countries: listCountry));
    });
  }
}
