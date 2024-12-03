import 'package:flutter/material.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk looping
    final List<Map<String, String>> quizData = [
      {"author": "Author 1", "category": "Kategori 1", "question": "Siapa nama pahlawan pada gambar 1?"},
      {"author": "Author 2", "category": "Kategori 2", "question": "Siapa nama pahlawan pada gambar 2?"},
      {"author": "Author 3", "category": "Kategori 3", "question": "Siapa nama pahlawan pada gambar 3?"},
      {"author": "Author 4", "category": "Kategori 4", "question": "Siapa nama pahlawan pada gambar 4?"},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang tetap
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), // Path gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          // PageView untuk konten
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: quizData.length, // Jumlah halaman sesuai data
            itemBuilder: (context, index) {
              final data = quizData[index]; // Data tiap item berdasarkan index

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data["author"] ?? "",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          data["category"] ?? "",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              data["question"] ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Masukkan jawaban Anda",
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 16.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity, // Memenuhi lebar layar
                            child: ElevatedButton(
                              onPressed: () {
                                // Aksi saat tombol "Cek" ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                              ),
                              child: const Text(
                                "Cek",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1A133E),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, -3),
        ),
      ],
    ),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10,
      ),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterKuisPage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahKuisPage()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PeringkatPage()));
            break;
          case 4:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilPage()));
            break;
        }
      },
      items: [
        _buildBottomNavigationBarItem(
          icon: Icons.home_rounded,
          label: 'Home',
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.search_rounded,
          label: 'Filter',
        ),
        _buildSpecialAddButton(),
        _buildBottomNavigationBarItem(
          icon: Icons.bar_chart_rounded,
          label: 'Ranking',
        ),
        _buildBottomNavigationBarItem(
          icon: Icons.person_rounded,
          label: 'Profile',
        ),
      ],
    ),
  );
}

// Helper method to create standard navigation bar items
BottomNavigationBarItem _buildBottomNavigationBarItem({
  required IconData icon,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Icon(icon, size: 24),
    activeIcon: Icon(icon, size: 28, color: Colors.white),
    label: label,
  );
}

// Special method to create a more prominent "Add" button
BottomNavigationBarItem _buildSpecialAddButton() {
  return BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: const Icon(
        Icons.add_rounded,
        color: Colors.white,
        size: 28,
      ),
    ),
    label: '',
  );
}
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}
