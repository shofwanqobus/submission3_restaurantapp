import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantapp_api/data/model/detail_restaurant_model.dart';

class DetailApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _category = 'detail/';

  Future<RestaurantDetails> detailRestaurantId(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _category + id));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menampilkan data restaurant');
    }
  }
}
