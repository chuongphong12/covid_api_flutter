import 'dart:convert';

class Country {
  String name;
  String iso2;
  String iso3;
  Country({
    required this.name,
    required this.iso2,
    required this.iso3,
  });

  Country copyWith({
    String? name,
    String? iso2,
    String? iso3,
  }) {
    return Country(
      name: name ?? this.name,
      iso2: iso2 ?? this.iso2,
      iso3: iso3 ?? this.iso3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iso2': iso2,
      'iso3': iso3,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] ?? '',
      iso2: map['iso2'] ?? '',
      iso3: map['iso3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) => Country.fromMap(json.decode(source));

  @override
  String toString() => 'Country(name: $name, iso2: $iso2, iso3: $iso3)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country && other.name == name && other.iso2 == iso2 && other.iso3 == iso3;
  }

  @override
  int get hashCode => name.hashCode ^ iso2.hashCode ^ iso3.hashCode;
}
