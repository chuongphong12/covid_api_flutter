import 'package:bloc/bloc.dart';
import 'package:covid_api_flutter/models/failure_model.dart';
import 'package:covid_api_flutter/models/statistic_model.dart';
import 'package:covid_api_flutter/repository/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final ApiRepository apiRepository;
  StatisticBloc({required this.apiRepository}) : super(StatisticInitial()) {
    on<FetchStatistic>((event, emit) async {
      emit(StatisticLoading());
      try {
        final statistic = await apiRepository.getStatistic();
        emit(StatisticLoaded(statistic: statistic));
      } catch (e) {
        emit(StatisticError(failure: Failure(message: e.toString(), code: '')));
      }
    });
  }
}
