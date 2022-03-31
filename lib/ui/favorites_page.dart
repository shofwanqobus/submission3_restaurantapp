import 'package:restaurantapp_api/provider/database_provider.dart';
import 'package:restaurantapp_api/data/state_enum.dart';
import 'package:restaurantapp_api/widgets/card_favorites.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
          alignment: Alignment.center,
          child: Text(
            favoritesTitle,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.justify,
          ),
        )),
        body: _buildList(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoritesTitle),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardFavorites(
                restaurantItems: provider.favorites[index],
              );
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(child: Text(provider.message));
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Icon(Icons.wifi_off, size: 50),
                ),
                Text(
                  provider.message,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
