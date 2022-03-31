import 'dart:async';

import 'package:restaurantapp_api/data/api/detail_api_service.dart';
import 'package:restaurantapp_api/data/model/detail_restaurant_model.dart';
import 'package:restaurantapp_api/data/state_enum.dart';
import 'package:flutter/material.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final DetailApiService apiService;
  final String id;

  DetailRestaurantProvider({
    required this.apiService,
    required this.id,
  }) {
    _fetchAllRestaurant(id);
  }

  late RestaurantDetails _restaurantDetails;
  late ResultState _state;
  String _message = '';

  RestaurantDetails get result => _restaurantDetails;
  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurantId(id);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetails = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Sayang sekali. \nCoba hubungkan internet kamu kembali!';
    }
  }
}
