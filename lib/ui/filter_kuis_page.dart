import 'package:flutter/material.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class FilterKuisPage extends StatelessWidget {
  const FilterKuisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A133E),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A133E),
        body: SafeArea(
          child: Column(
            children: [
              // Bagian atas
              _buildTop(context),
              // Expanded untuk memberi ruang bagi konten lainnya
              Expanded(
                child: _buildBottom(context),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16), // Menambahkan margin atas
      child: SizedBox(
        width: mediaSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row untuk tombol kembali dan judul
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    "Filter Kuis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Kategori',
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF6A5AE0)),
                    ),
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    bool showAllQuizzes = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: mediaSize.width,
            height: mediaSize.height *
                0.7, // Tetapkan tinggi tetap untuk bagian bawah
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Kuis",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showAllQuizzes = !showAllQuizzes;
                            });
                          },
                          child: const Text(
                            "Lihat semua",
                            style: TextStyle(
                              color: Color(0xFF6A5AE0),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _buildQuizList(showAllQuizzes ? null : 4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildQuizList(int? maxItems) {
    // Data untuk daftar kuis
    final quizzes = [
      {
        'title': 'Statistics Math Quiz',
        'category': 'Math',
        'count': 12,
        'color': Colors.white,
      },
      {
        'title': 'Statistics Math Quiz',
        'category': 'Math',
        'count': 12,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      {
        'title': 'Matrices Quiz',
        'category': 'Math',
        'count': 6,
        'color': Colors.white,
      },
      // Tambahkan lebih banyak kuis jika diperlukan
    ];

    // Jika maxItems tidak null, tampilkan hanya sejumlah item yang ditentukan
    final displayedQuizzes =
        maxItems != null ? quizzes.take(maxItems).toList() : quizzes;

    return displayedQuizzes.map((quiz) {
      return Card(
        color: quiz['color'] as Color?,
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Icon(
            Icons.quiz,
            color: Colors.blue[700],
            size: 40,
          ),
          title: Text(
            quiz['title'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
            "${quiz['category']} • ${quiz['count']} Quizzes",
            style: const TextStyle(
              color: Color(0xFF858494),
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Color(0xFF6A5AE0),
          ),
          onTap: () {
            // Tambahkan fungsi navigasi ke detail kuis
          },
        ),
      );
    }).toList();
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
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Homepage()));
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FilterKuisPage()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahKuisPage()));
              break;
            case 3:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PeringkatPage()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilPage()));
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
            colors: [Colors.amber, const Color.fromARGB(255, 210, 159, 5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
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
