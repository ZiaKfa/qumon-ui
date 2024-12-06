import 'package:flutter/material.dart';
import 'package:qumon/bloc/kategori_bloc.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class FilterKuisPage extends StatefulWidget {
  const FilterKuisPage({super.key});

  @override
  _FilterKuisPageState createState() => _FilterKuisPageState();
}

class _FilterKuisPageState extends State<FilterKuisPage> {
  late Future<List> kategoriList;

  @override
  void initState() {
    super.initState();
    // Mengambil data kategori saat halaman dimuat
    kategoriList = KategoriBloc().getKategori();
  }

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
      padding: const EdgeInsets.only(top: 16),
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
            height: mediaSize.height * 0.7,
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
                      child: FutureBuilder<List>(
                        future: kategoriList, // Memanggil kategori dari API
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('Tidak ada kategori'));
                          } else {
                            // Data kategori berhasil diambil, tampilkan di sini
                            var categories = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(
                                children: categories.map((category) {
                                  return Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(16),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          'assets/images/kuis.jpg',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        category['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${category['quiz_count']} Kuis",
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
                                        // Navigation logic
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
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
          gradient: const LinearGradient(
            colors: [Colors.amber, Color.fromARGB(255, 210, 159, 5)],
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
