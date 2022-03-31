import 'dart:async';

import 'package:restaurantapp_api/data/api/search_api_service.dart';
import 'package:restaurantapp_api/data/model/search_restaurant_model.dart';
import 'package:restaurantapp_api/data/state_enum.dart';
import 'package:flutter/material.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final SearchApiService apiService;
  final String query;

  SearchRestaurantProvider({
    required this.apiService,
    required this.query,
  }) {
    fetchAllRestaurant(query);
  }

  late RestaurantSearch _restaurant;
  late ResultState _state;
  String _message = '';

  RestaurantSearch get result => _restaurant;
  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurantQuery(query);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Sayang sekali. \nCoba hubungkan internet kamu kembali!';
    }
  }
}
