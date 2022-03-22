part of 'statistic_bloc.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final Statistic statistic;

  const StatisticLoaded({required this.statistic});

  @override
  List<Object> get props => [statistic];
}

class StatisticError extends StatisticState {
  final Failure failure;

  const StatisticError({required this.failure});

  @override
  List<Object> get props => [failure];
}
