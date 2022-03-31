import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantapp_api/data/model/restaurant.dart';

class RestaurantApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _category = 'list';

  Future<Restaurant> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl + _category));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Mohon maaf data restaurant tidak dapat ditampilkan');
    }
  }
}
