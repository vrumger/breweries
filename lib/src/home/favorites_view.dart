import 'package:brewery/src/home/brewery_card.dart';
import 'package:brewery/src/models/brewery.dart';
import 'package:flutter/material.dart';

class FavoriteBreweriesView extends StatefulWidget {
  const FavoriteBreweriesView({super.key});

  @override
  State<FavoriteBreweriesView> createState() => _FavoriteBreweriesViewState();
}

class _FavoriteBreweriesViewState extends State<FavoriteBreweriesView> {
  late Future<Map<String, Brewery>> favoriteBreweries;

  @override
  void initState() {
    super.initState();
    favoriteBreweries = getFavoriteBreweries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brewery>>(
      future: favoriteBreweries
          .then<List<Brewery>>((favorites) => favorites.values.toList()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;

          if (items.isNotEmpty) {
            return ListView.builder(
              restorationId: 'favoriteBreweriesListItemView',
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                Brewery item = items[index];

                return BreweryCard(
                  isFavorite: true,
                  item: item,
                  addFavorite: () {},
                  removeFavorite: () async {
                    setState(() {
                      items.remove(item);
                    });

                    var favoritesMap = await favoriteBreweries;
                    favoritesMap.remove(item.id);
                    await saveFavoriteBreweries(favoritesMap);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No favorites'),
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
