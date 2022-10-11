import 'package:brewery/src/models/brewery.dart';
import 'package:flutter/material.dart';

class BreweriesView extends StatefulWidget {
  const BreweriesView({super.key});

  @override
  State<BreweriesView> createState() => _BreweriesViewState();
}

class _BreweriesViewState extends State<BreweriesView> {
  late Future<List<Brewery>> breweries;

  @override
  void initState() {
    super.initState();
    breweries = fetchBreweries();
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
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Align(
                        heightFactor: 0,
                        alignment: const Alignment(1, -0.5),
                        child: IconButton(
                          icon: const Icon(Icons.star_border),
                          onPressed: () {
                            // TODO:
                          },
                        ),
                      ),
                      Text(item.name, style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      Text(item.breweryType,
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                      const SizedBox(height: 10),
                      if (item.street != null) Text(item.street!),
                      if (item.address2 != null) Text(item.address2!),
                      if (item.address3 != null) Text(item.address3!),
                    ],
                  ),
                ),
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
