part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class FetchAllCountry extends CountryEvent {}

class ChangeCountry extends CountryEvent {
  final Country? country;

  const ChangeCountry({required this.country});

  @override
  List<Object> get props => [country!];
}
