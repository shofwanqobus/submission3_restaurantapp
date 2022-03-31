import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:restaurantapp_api/data/api/detail_api_service.dart';
import 'package:restaurantapp_api/design/styles.dart';
import 'package:restaurantapp_api/provider/detail_restaurant_provider.dart';
import 'package:restaurantapp_api/data/state_enum.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';
import 'package:restaurantapp_api/widgets/card_details.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String id;

  const DetailRestaurant({
    required this.id,
  });

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) =>
            DetailRestaurantProvider(apiService: DetailApiService(), id: id),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final resto = state.result.restaurant;
              return Details(
                restaurantItems: resto,
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 250),
                      child: Icon(Icons.wifi_off, size: 50),
                    ),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ));
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _buildList(context),
    );
  }

  Widget _buildios(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildios,
    );
  }
}
