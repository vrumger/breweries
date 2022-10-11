import 'package:brewery/src/home/breweries_view.dart';
import 'package:brewery/src/models/brewery.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Breweries'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              // Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BreweriesView(),
            // FavoriteBreweriesView(),
          ],
        ),
      ),
    );
  }
}
