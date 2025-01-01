import 'package:flutter/material.dart';

class FavorilerPage extends StatefulWidget {
  const FavorilerPage({super.key});

  @override
  _FavorilerPageState createState() => _FavorilerPageState();
}

class _FavorilerPageState extends State<FavorilerPage> {
  String selectedCategory = 'Yemek'; // Varsayılan kategori

  // Örnek favori verileri
  final List<Map<String, String>> geziFavoriler = [
    {
      'title': 'Topkapı Sarayı',
      'image':
      'https://muzeler.org/images/google-place-images/topkapi-sarayi-muzesi.jpg'
    }
  ];
  final List<Map<String, String>> yemekFavoriler = [
    {
      'title': 'Nusr-Et',
      'image':
      'https://www.nusr-et.com.tr/Resources/VenueBanner/ImageFile/etilerbanner4_l.jpg'
    }
  ];

  void _navigateToDetailPage(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetaySayfasi(
          title: item['title']!,
          imageUrl: item['image']!,
          onSave: (isSaved) {
            setState(() {
              if (selectedCategory == 'Gezi') {
                if (isSaved) {
                  geziFavoriler.add(item);
                } else {
                  geziFavoriler.remove(item);
                }
              } else {
                if (isSaved) {
                  yemekFavoriler.add(item);
                } else {
                  yemekFavoriler.remove(item);
                }
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favoriler',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.orange,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            // Kategori seçim butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Gezi';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: selectedCategory == 'Gezi'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    minimumSize: const Size(180, 50),
                  ),
                  child: Text(
                    'Gezi',
                    style: TextStyle(
                      color: selectedCategory == 'Gezi'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Yemek';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: selectedCategory == 'Yemek'
                        ? Colors.blue
                        : Colors.grey.shade300,
                    minimumSize: const Size(180, 50),
                  ),
                  child: Text(
                    'Yemek',
                    style: TextStyle(
                      color: selectedCategory == 'Yemek'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Seçilen kategoriye göre favoriler listesi
            Expanded(
              child: ListView.builder(
                itemCount: selectedCategory == 'Gezi'
                    ? geziFavoriler.length
                    : yemekFavoriler.length,
                itemBuilder: (context, index) {
                  final item = selectedCategory == 'Gezi'
                      ? geziFavoriler[index]
                      : yemekFavoriler[index];
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Oval kenarlar
                      side: BorderSide(
                        color: Colors.orange.shade400, // Dış çizgi (stroke)
                        width: 1.5,
                      ),
                    ),
                    elevation: 4,
                    child: Row(
                      children: [
                        // Sol resim (Image.network ile URL)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.network(
                            item['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.orange.shade100,
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Ortada Column ile isim ve detaylar
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Detaylar için basın',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Sağda Detay Sayfasına gitme butonu
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            _navigateToDetailPage(context, item);
                          },
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
    );
  }
}

class DetaySayfasi extends StatefulWidget {
  final String title;
  final String imageUrl;
  final Function(bool) onSave;

  const DetaySayfasi({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onSave,
  });

  @override
  _DetaySayfasiState createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              setState(() {
                isSaved = !isSaved;
              });
              widget.onSave(isSaved);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              color: Colors.orange.shade100,
              child: const Icon(
                Icons.error,
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Detaylar',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
