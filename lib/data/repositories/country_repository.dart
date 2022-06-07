import 'package:country_app/data/models/country_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryRepository {
  final String _baseUrl = "https://restcountries.com/v3.1/all";
  List<CountryModel> countryList = [];

  Future<List<CountryModel>> getCountries() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body) as List;

      for (var element in jsonList) {
        countryList.add(CountryModel.fromJson(element));
      }
      return countryList;
    } else {
      throw Exception('Failed to load countries.');
    }
  }
}
