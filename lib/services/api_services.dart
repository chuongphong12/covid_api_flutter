import 'package:covid_api_flutter/constants/constant.dart';
import 'package:dio/dio.dart';

class ApiService {
  final _dio = Dio();

  Future<Response> fetchAllCountry() async {
    try {
      final Response res = await _dio.get(baseUrl);
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> fetchCountries() async {
    try {
      final Response res = await _dio.get('$baseUrl$countriesUrl');
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> fetchDataByCountry(String countryId) async {
    try {
      final Response res = await _dio.get('$baseUrl$countriesUrl/$countryId');
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> fetchDataImage() async {
    try {
      final Response res = await _dio.get('$baseUrl/og');
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> fetchGraphByCountry(String countryId) async {
    try {
      final Response res = await _dio.get('$baseUrl$countriesUrl/$countryId/og');
      return res;
    } catch (e) {
      throw Exception(e);
    }
  }
}
