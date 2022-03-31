import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp_api/data/api/search_api_service.dart';
import 'package:restaurantapp_api/data/state_enum.dart';
import 'package:restaurantapp_api/provider/search_restaurant_provider.dart';
import 'package:restaurantapp_api/widgets/card_search.dart';
import 'package:restaurantapp_api/widgets/platform_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  static const String searchName = 'Search';

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  static const String searchName = 'Search';
  TextEditingController textEditingController = TextEditingController();
  String query = '';

  Widget _buildList(context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var resto = state.result.restaurants[index];
              return Search(restaurantItems: resto);
            },
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
                  padding: EdgeInsets.only(top: 200),
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
    );
  }

  Widget _buildSearch(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(
          apiService: SearchApiService(), query: query),
      child: Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.search),
                        title: TextField(
                          autofocus: true,
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Search restaurant....',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                            state.fetchAllRestaurant(query);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 100, left: 32, right: 32, bottom: 24),
                  child: query.isEmpty
                      ? const Center(child: Text(''))
                      : _buildList(context),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
          alignment: Alignment.center,
          child: Text(
            'Search Restaurant',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.justify,
          ),
        )),
        body: _buildSearch(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search Restaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildSearch(context),
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
