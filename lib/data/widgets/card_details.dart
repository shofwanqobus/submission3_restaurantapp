import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp_api/data/model/detail_restaurant_model.dart';
import 'package:restaurantapp_api/provider/database_provider.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';

class Details extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantItems restaurantItems;

  const Details({required this.restaurantItems});

  Widget _details() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurantItems.id),
          builder: ((context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        SafeArea(
                          child: Hero(
                            tag: restaurantItems.pictureId,
                            child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/large/' +
                                    restaurantItems.pictureId),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white54,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                isFavorited == true
                                    ? IconButton(
                                        icon: const Icon(Icons.favorite),
                                        color: Colors.red,
                                        onPressed: () => provider
                                            .removeFavorite(restaurantItems.id),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.favorite_border),
                                        color: Colors.red,
                                        onPressed: () => provider
                                            .addFavorite(restaurantItems),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 4, bottom: 12),
                            child: Text(
                              restaurantItems.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(restaurantItems.city),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      '${restaurantItems.rating}',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_city_rounded,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      restaurantItems.address,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.food_bank_rounded,
                                    size: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    height: 30,
                                    width: 200,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: restaurantItems.categories
                                          .map(
                                            (Category) => Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6),
                                                      child: Text(
                                                        '${Category.name} ',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                top: 24, left: 4, right: 16),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Deskripsi',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 1),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    restaurantItems.description,
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 16, left: 4),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Menu yang tersedia dalam Restaurant ${restaurantItems.name}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Makanan',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 130,
                                  width: 300,
                                  alignment: Alignment.center,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: restaurantItems.menus.foods
                                        .map(
                                          (Foods) => Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'images/foods.jpg',
                                                      height: 75,
                                                      width: 75,
                                                    ),
                                                    Text(Foods.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Minuman',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 130,
                                  width: 300,
                                  alignment: Alignment.centerLeft,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: restaurantItems.menus.drinks
                                        .map(
                                          (Drinks) => Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'images/drinks.jpg',
                                                      height: 75,
                                                      width: 75,
                                                    ),
                                                    Text(Drinks.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.only(top: 16, left: 4),
                                  child: Text(
                                    'Customer Review',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  height: 130,
                                  alignment: Alignment.centerLeft,
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: restaurantItems.customerReviews
                                        .map(
                                          (CustomerReview) => Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          '${CustomerReview.name} (${CustomerReview.date}) : \n'
                                                          '${CustomerReview.review}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body: _details());
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.white,
      ),
      child: _details(),
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
