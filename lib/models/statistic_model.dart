// To parse this JSON data, do
//
//     final statistic = statisticFromJson(jsonString);

import 'dart:convert';

Statistic statisticFromJson(String str) => Statistic.fromJson(json.decode(str));

String statisticToJson(Statistic data) => json.encode(data.toJson());

class Statistic {
  Statistic({
    required this.confirmed,
    required this.recovered,
    required this.deaths,
    required this.lastUpdate,
  });

  final Case confirmed;
  final Case recovered;
  final Case deaths;
  final String lastUpdate;

  Statistic copyWith({
    Case? confirmed,
    Case? recovered,
    Case? deaths,
    String? lastUpdate,
  }) =>
      Statistic(
        confirmed: confirmed ?? this.confirmed,
        recovered: recovered ?? this.recovered,
        deaths: deaths ?? this.deaths,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        confirmed: Case.fromJson(json["confirmed"]),
        recovered: Case.fromJson(json["recovered"]),
        deaths: Case.fromJson(json["deaths"]),
        lastUpdate: json["lastUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed.toJson(),
        "recovered": recovered.toJson(),
        "deaths": deaths.toJson(),
        "lastUpdate": lastUpdate,
      };
}

class Case {
  Case({
    required this.value,
    required this.detail,
  });

  final int value;
  final String detail;

  Case copyWith({
    int? value,
    String? detail,
  }) =>
      Case(
        value: value ?? this.value,
        detail: detail ?? this.detail,
      );

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        value: json["value"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "detail": detail,
      };
}
