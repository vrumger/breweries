// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Brewery>> fetchBreweries() async {
  final response =
      await http.get(Uri.parse('https://api.openbrewerydb.org/breweries'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    return json.map((brewery) => Brewery.fromJson(brewery)).toList();
  }

  throw Exception('Failed to fetch breweries');
}

Future<Map<String, Brewery>> getFavoriteBreweries() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? favoritesString = prefs.getString('favorites');
  Map<String, Brewery> favorites = favoritesString != null
      ? Map.from(jsonDecode(favoritesString))
          .map((key, value) => MapEntry(key, Brewery.fromJson(value)))
      : {};

  return favorites;
}

Future<void> saveFavoriteBreweries(Map<String, Brewery> favorites) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('favorites', jsonEncode(favorites));
}

class Brewery {
  final String id;
  final String name;
  final String brewery_type;
  final String? street;
  final String? address_2;
  final String? address_3;
  final String city;
  final String? state;
  final String? county_province;
  final String postal_code;
  final String country;
  final String? longitude;
  final String? latitude;
  final String? phone;
  final String? website_url;
  final String created_at;
  final String updated_at;

  const Brewery({
    required this.id,
    required this.name,
    required this.brewery_type,
    required this.street,
    required this.address_2,
    required this.address_3,
    required this.city,
    required this.state,
    required this.county_province,
    required this.postal_code,
    required this.country,
    required this.longitude,
    required this.latitude,
    required this.phone,
    required this.website_url,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brewery_type': brewery_type,
        'street': street,
        'address_2': address_2,
        'address_3': address_3,
        'city': city,
        'state': state,
        'county_province': county_province,
        'postal_code': postal_code,
        'country': country,
        'longitude': longitude,
        'latitude': latitude,
        'phone': phone,
        'website_url': website_url,
        'created_at': created_at,
        'updated_at': updated_at,
      };

  factory Brewery.fromJson(Map<String, dynamic> json) {
    return Brewery(
      id: json['id'],
      name: json['name'],
      brewery_type: json['brewery_type'],
      street: json['street'],
      address_2: json['address_2'],
      address_3: json['address_3'],
      city: json['city'],
      state: json['state'],
      county_province: json['county_province'],
      postal_code: json['postal_code'],
      country: json['country'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      phone: json['phone'],
      website_url: json['website_url'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
