import 'package:flutter/material.dart';

class YemekPage extends StatefulWidget {
  const YemekPage({super.key});

  @override
  _YemekPageState createState() => _YemekPageState();
}

class _YemekPageState extends State<YemekPage> {
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

  final Map<String, List<String>> cityRestaurants = {
    'Adana': ['Kebapçı Halil', 'Ciğerci Mustafa'],
    'Ankara': ['Trilye Restoran', 'Boğaziçi Lokantası'],
    'İstanbul': [
      'Nusr-Et',
      'Mikla Restoran',
      'Balıkçı Sabahattin',
      'Çiya Sofrası',
      'Karaköy Lokantası',
      'Borsa Lokantası'
    ],
    'İzmir': ['Deniz Restoran', 'Topçu Restoran'],
    'Antalya': ['Seraser Fine Dining', '7 Mehmet'],
    'Bursa': ['İskender Kebap', 'Hünkar Lokantası'],
  };

  String searchText = '';
  List<String> filteredCities = [];
  List<String> selectedCityRestaurants = [];
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
      selectedCityRestaurants = cityRestaurants[city] ?? [];
    });
  }

  void _onSearchFieldTapped() {
    setState(() {
      searchText = '';
      isSearching = true;
      filteredCities = allCities;
    });
  }

  void _navigateToDetailPage(BuildContext context, String restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetaySayfasi(title: restaurant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Yemek',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.orange,
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
                    fillColor: Colors.grey.shade100,
                    hintText: 'Şehir Ara',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                      const BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (selectedCityRestaurants.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedCityRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = selectedCityRestaurants[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                                color: Colors.orange, width: 1),
                          ),
                          elevation: 3,
                          child: Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Kısa detaylar burada olacak.',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () =>
                                    _navigateToDetailPage(context, restaurant),
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
                                  : Colors.orange,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          city,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
  _DetaySayfasiState createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.bookmark : Icons.bookmark_border_outlined,
              color: isFavorite ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              _toggleFavorite();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? '${widget.title} favorilere eklendi!'
                        : '${widget.title} favorilerden çıkarıldı!',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://www.nusr-et.com.tr/Resources/VenueBanner/ImageFile/etilerbanner4_l.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nusret Gökçe, 2010 yılında İstanbul’da ilk restoranını açtığında, kaliteli et ve özel pişirme teknikleriyle fark yaratmayı hedefledi. Ancak, dünya çapında tanınmasını sağlayan asıl olay, 2017 yılında sosyal medyada viral olan “tuz serpme” hareketi oldu. Bu ikonik hareket, Nusret markasının global düzeyde bir fenomen haline gelmesine yol açtı. Bugün, Nusret restoranları New York, Miami, Londra, Dubai gibi pek çok büyük şehirde hizmet verirken, İstanbul’daki şube, markanın doğduğu yer olarak özel bir yere sahiptir. Nusret İstanbul, şıklığı ve zarafeti bir araya getiren modern bir dekorasyona sahiptir. İç mekan tasarımı, sıcak ahşap tonları ve endüstriyel dokunuşlarla sofistike bir hava yaratır. Açık mutfak konsepti sayesinde, müşteriler yemeklerinin hazırlanışını izleyebilir ve deneyimin bir parçası olabilir. Ayrıca, özenle seçilmiş müzikler, restoranın enerjik atmosferine katkıda bulunur.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 30,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Adres: Bebek, İstanbul',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
