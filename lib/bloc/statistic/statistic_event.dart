part of 'statistic_bloc.dart';

abstract class StatisticEvent extends Equatable {
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

class FetchStatistic extends StatisticEvent {}

class FetchStatisticByCountry extends StatisticEvent {
  final String? country;

  const FetchStatisticByCountry({required this.country});

  @override
  List<Object> get props => [country!];
}
