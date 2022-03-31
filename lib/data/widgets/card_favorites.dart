import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp_api/data/model/detail_restaurant_model.dart';
import 'package:restaurantapp_api/provider/database_provider.dart';
import 'package:restaurantapp_api/ui/details.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';

class CardFavorites extends StatelessWidget {
  final RestaurantItems restaurantItems;

  const CardFavorites({required this.restaurantItems});

  Widget _favorites(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurantItems.id),
          builder: (context, snapshot) {
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurantItems.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/large/' +
                        restaurantItems.pictureId,
                    width: 100,
                  ),
                ),
                title: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 2,
                    bottom: 4,
                  ),
                  child: Text(restaurantItems.name),
                ),
                subtitle: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 15,
                            ),
                            Text(restaurantItems.city),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 15),
                            Text('${restaurantItems.rating}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailRestaurant(id: restaurantItems.id);
                  }));
                },
              ),
            );
          });
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body: _favorites(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.white,
      ),
      child: _favorites(context),
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
