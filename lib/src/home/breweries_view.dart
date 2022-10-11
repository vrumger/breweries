import 'package:brewery/src/home/brewery_card.dart';
import 'package:brewery/src/models/brewery.dart';
import 'package:flutter/material.dart';

class BreweriesView extends StatefulWidget {
  const BreweriesView({super.key});

  @override
  State<BreweriesView> createState() => _BreweriesViewState();
}

class _BreweriesViewState extends State<BreweriesView> {
  late Future<List<Brewery>> breweries;
  late Map<String, Brewery> favorites;

  @override
  void initState() {
    super.initState();
    breweries = fetchBreweries();

    getFavoriteBreweries().then((favorites) => this.favorites = favorites);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brewery>>(
      future: breweries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;

          return ListView.builder(
            restorationId: 'breweryItemListView',
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              Brewery item = items[index];
              bool isFavorite = favorites.containsKey(item.id);

              return BreweryCard(
                isFavorite: isFavorite,
                item: item,
                addFavorite: () async {
                  setState(() {
                    favorites.putIfAbsent(item.id, () => item);
                  });
                  await saveFavoriteBreweries(favorites);
                },
                removeFavorite: () async {
                  setState(() {
                    favorites.remove(item.id);
                  });
                  await saveFavoriteBreweries(favorites);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
