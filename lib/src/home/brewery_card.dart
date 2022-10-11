import 'package:brewery/src/models/brewery.dart';
import 'package:flutter/material.dart';

class BreweryCard extends StatelessWidget {
  final bool isFavorite;
  final Brewery item;
  final void Function() addFavorite;
  final void Function() removeFavorite;

  const BreweryCard({
    super.key,
    required this.isFavorite,
    required this.item,
    required this.addFavorite,
    required this.removeFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.blue : Colors.white,
              ),
              onPressed: () {
                if (isFavorite) {
                  removeFavorite();
                } else {
                  addFavorite();
                }
              },
            ),
            Text(item.name, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(item.brewery_type,
                style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            if (item.street != null) Text(item.street!),
            if (item.address_2 != null) Text(item.address_2!),
            if (item.address_3 != null) Text(item.address_3!),
          ],
        ),
      ),
    );
  }
}
