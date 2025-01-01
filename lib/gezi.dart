import 'package:flutter/material.dart';

bool isDarkTheme = false;
String currentLanguage = 'English'; // Default language is set to English

class GeziPage extends StatefulWidget {
  const GeziPage({super.key});

  @override
  _GeziPageState createState() => _GeziPageState();
}

class _GeziPageState extends State<GeziPage> {
  final List<String> allCities = [
    'Adana',
    'Ankara',
    'İstanbul',
    'İzmir',
    'Antalya',
    'Bursa',
    'Eskişehir',
    'Konya',
    'Trabzon',
    'Gaziantep',
  ];

  final Map<String, List<String>> cityAttractions = {
    'Adana': ['Taş Köprü', 'Seyhan Nehri'],
    'Ankara': ['Anıtkabir', 'Kocatepe Camii'],
    'İstanbul': [
      'Topkapı Sarayı',
      'Galata Kulesi',
      'Yerebatan Sarnıcı',
      'Dolmabahçe Sarayı',
      'Kapalıçarşı',
      'Ayasofya'
    ],
    'İzmir': ['Efes Antik Kenti', 'Saat Kulesi'],
    'Antalya': ['Kaleiçi', 'Düden Şelalesi'],
    'Bursa': ['Uludağ', 'Yeşil Türbe'],
  };

  String searchText = '';
  List<String> filteredCities = [];
  List<String> selectedCityAttractions = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredCities = allCities;
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
      filteredCities = allCities
          .where((city) => city.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onCitySelected(String city) {
    setState(() {
      searchText = city;
      isSearching = false;
      selectedCityAttractions = cityAttractions[city] ?? [];
    });
  }

  void _onSearchFieldTapped() {
    setState(() {
      searchText = '';
      isSearching = true;
      filteredCities = allCities;
    });
  }

  void _navigateToDetailPage(BuildContext context, String attraction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetaySayfasi(title: attraction),
      ),
    );
  }

  String _getLocalizedText(String tr, String en) {
    return currentLanguage == 'English' ? en : tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _getLocalizedText('Gezi', 'Travel'),
          style: TextStyle(
            fontSize: 30,
            color: isDarkTheme ? Colors.white : Colors.orange,
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: _onSearchChanged,
                  onTap: _onSearchFieldTapped,
                  controller: TextEditingController(text: searchText),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDarkTheme
                        ? Colors.grey.shade800
                        : Colors.grey.shade100,
                    hintText: _getLocalizedText('Şehir Ara', 'Search City'),
                    hintStyle: TextStyle(
                      color: isDarkTheme ? Colors.grey.shade400 : Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDarkTheme ? Colors.white : Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: isDarkTheme ? Colors.orange : Colors.orange,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (selectedCityAttractions.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedCityAttractions.length,
                      itemBuilder: (context, index) {
                        final attraction = selectedCityAttractions[index];
                        return Card(
                          color:
                          isDarkTheme ? Colors.grey.shade800 : Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color:
                              isDarkTheme ? Colors.orange : Colors.orange,
                              width: 1,
                            ),
                          ),
                          elevation: 3,
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: isDarkTheme
                                      ? Colors.grey.shade700
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      {
                                        'Ayasofya':
                                        'https://webdosya.diyanet.gov.tr/DiyanetAnasayfa/UserFiles/00000000-0000-0000-0000-000000000000/2020/7/14/c3e5787b-6413-4f9b-8ad6-aa685ea6fd80_4_760x506.jpg',
                                        'Topkapı Sarayı':
                                        'https://muzeler.org/images/google-place-images/topkapi-sarayi-muzesi.jpg',
                                        'Galata Kulesi':
                                        'https://loibosphorus.com/wp-content/uploads/2023/09/galata-kulesi.jpg',
                                        'Yerebatan Sarnıcı':
                                        'https://yerebatan.com/wp-content/uploads/2022/12/yerebatan-sergi-ogu5749-min-FX7w-scaled-1.jpg',
                                        'Dolmabahçe Sarayı':
                                        'https://www.flypgs.com/blog/wp-content/uploads/2024/05/dolmabahce-sarayi-hakkinda-bilgiler.jpeg',
                                        'Kapalıçarşı':
                                        'https://istanbuluseyret.ibb.gov.tr/wp-content/uploads/2021/10/kapalicarsi.jpg'
                                      }[attraction] ??
                                          '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      attraction,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getLocalizedText(
                                          'Kısa detaylar burada olacak.',
                                          'Tap for details'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkTheme
                                            ? Colors.grey.shade400
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: isDarkTheme
                                      ? Colors.orange
                                      : Colors.orange,
                                ),
                                onPressed: () =>
                                    _navigateToDetailPage(context, attraction),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          if (isSearching)
            Positioned(
              left: 16,
              right: 16,
              top: 100,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    return GestureDetector(
                      onTap: () => _onCitySelected(city),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index == filteredCities.length - 1
                                  ? Colors.transparent
                                  : (isDarkTheme ? Colors.grey : Colors.orange),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          city,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DetaySayfasi extends StatefulWidget {
  final String title;

  const DetaySayfasi({super.key, required this.title});

  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Details for ${widget.title}'),
      ),
    );
  }
}
