part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<Country> countries;

  const CountryLoaded({required this.countries});

  @override
  List<Object> get props => [countries];
}

class CountrySelected extends CountryState {
  final Country country;

  const CountrySelected({required this.country});

  @override
  List<Object> get props => [country];
}

class CountryError extends CountryState {
  final Failure failure;

  const CountryError({required this.failure});

  @override
  List<Object> get props => [failure];
}
