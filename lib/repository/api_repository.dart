import 'package:covid_api_flutter/models/country_model.dart';
import 'package:covid_api_flutter/models/statistic_model.dart';
import 'package:covid_api_flutter/services/api_services.dart';

class ApiRepository {
  final _apiService = ApiService();

  Future<List<Country>> getAllCountry() async {
    try {
      final response = await _apiService.fetchCountries();
      List<dynamic> data = response.data['countries'];

      List<Country> countryList =
          data.map((country) => Country.fromMap(country)).toList();
      return countryList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Statistic> getStatistic() async {
    try {
      final response = await _apiService.fetchAllCountry();
      Statistic statistic = Statistic.fromJson(response.data);
      return statistic;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Statistic> getStatisticByCountry(String country) async {
    try {
      final response = await _apiService.fetchDataByCountry(country);
      Statistic data = Statistic.fromJson(response.data);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
