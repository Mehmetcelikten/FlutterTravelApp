import 'package:flutter/material.dart';
import 'package:fluttertravelapp/favorites_view.dart';
import 'package:fluttertravelapp/gezi.dart';
import 'package:fluttertravelapp/yemek_view.dart';





class BottomNav extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BottomNav> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDarkTheme) {
    setState(() {
      _themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: BottomNavigationExample(onThemeChanged: toggleTheme),
    );
  }
}

class BottomNavigationExample extends StatelessWidget {
  final Function(bool) onThemeChanged;

  BottomNavigationExample({required this.onThemeChanged});

  final List<Widget> _pages = [
    GeziPage(), // Gezi sayfası
    YemekPage(), // Yemek sayfası
    FavorilerPage(), // Favori sayfası
    AyarlarPage(), // Ayarlar sayfası
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: _pages,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 0),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.location_city, size: 24), text: 'City'),
              Tab(icon: Icon(Icons.restaurant, size: 24), text: 'Food'),
              Tab(icon: Icon(Icons.favorite, size: 24), text: 'Favorites'),
              Tab(icon: Icon(Icons.settings, size: 24), text: 'Settings'),
            ],
            labelColor: Colors.orange[500],
            unselectedLabelColor: Colors.amber[100],
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}

class AyarlarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tema Değiştir', style: TextStyle(fontSize: 18)),
                Switch(
                  value: themeMode,
                  onChanged: (value) {
                    final toggleTheme =
                        (context.findAncestorWidgetOfExactType<BottomNav>()
                        as BottomNav)
                            .createState()
                            .toggleTheme;
                    toggleTheme(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Ayarlar Sayfası İçeriği',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
