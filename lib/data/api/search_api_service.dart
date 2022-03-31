import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantapp_api/data/model/search_restaurant_model.dart';

class SearchApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _category = 'search?q=';

  Future<RestaurantSearch> searchRestaurantQuery(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _category + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Gagal melakukan pencarian. Silahkan coba kembali nanti...');
    }
  }
}
