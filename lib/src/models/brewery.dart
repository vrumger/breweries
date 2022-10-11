import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

Future<List<Brewery>> fetchBreweries() async {
  final response =
      await http.get(Uri.parse('https://api.openbrewerydb.org/breweries'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    return json.map((brewery) => Brewery.fromJson(brewery)).toList();
  }

  throw Exception('Failed to fetch breweries');
}

class Brewery {
  final String id;
  final String name;
  final String breweryType;
  final String? street;
  final String? address2;
  final String? address3;
  final String city;
  final String? state;
  final String? countyProvince;
  final String postalCode;
  final String country;
  final String? longitude;
  final String? latitude;
  final String? phone;
  final String? websiteUrl;
  final String createdAt;
  final String updatedAt;

  const Brewery({
    required this.id,
    required this.name,
    required this.breweryType,
    required this.street,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.countyProvince,
    required this.postalCode,
    required this.country,
    required this.longitude,
    required this.latitude,
    required this.phone,
    required this.websiteUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Brewery.fromJson(Map<String, dynamic> json) {
    return Brewery(
      id: json['id'],
      name: json['name'],
      breweryType: json['brewery_type'],
      street: json['street'],
      address2: json['address_2'],
      address3: json['address_3'],
      city: json['city'],
      state: json['state'],
      countyProvince: json['county_province'],
      postalCode: json['postal_code'],
      country: json['country'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      phone: json['phone'],
      websiteUrl: json['website_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
