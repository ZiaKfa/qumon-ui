import 'package:flutter/material.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class PeringkatPage extends StatefulWidget {
  const PeringkatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PeringkatPageState createState() => _PeringkatPageState();
}

class _PeringkatPageState extends State<PeringkatPage> {
  bool isWeeklySelected = true; // default to weekly

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A133E),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A133E),
        body: Stack(children: [
          Positioned(top: 40, child: _buildTop(context)),
          Positioned(bottom: 0, child: _buildBottom(context)),
        ]),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row for back button and title
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
                  "Peringkat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 100.0), // Mengatur padding kiri dan kanan
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isWeeklySelected = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: isWeeklySelected
                            ? Colors.amber
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Mingguan",
                          style: TextStyle(
                            color:
                                isWeeklySelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isWeeklySelected = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: !isWeeklySelected
                            ? Colors.amber
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Total",
                          style: TextStyle(
                            color:
                                !isWeeklySelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
  }

  Widget _buildBottom(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    bool showAllQuizzes = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          width: mediaSize.width,
          height: mediaSize.height *
              0.75, // Tetapkan tinggi tetap untuk bagian bawah
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
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                            _buildRankingList(), // Tampilkan semua data, tidak ada batasan jumlah item
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    // ignore: dead_code
    return Container();
  }

  List<Widget> _buildRankingList() {
    // Data untuk daftar peringkat
    final rankings = [
      {
        'rank': 1,
        'name': 'Muhammad Khadziq',
        'points': 2569,
        'countryFlag': '🇵🇹',
        'profilePic': 'https://link.to/profile1.jpg',
      },
      {
        'rank': 2,
        'name': 'Ziakfa',
        'points': 1469,
        'countryFlag': '🇫🇷',
        'profilePic': 'https://link.to/profile2.jpg',
      },
      {
        'rank': 3,
        'name': 'Daniel Abdillah',
        'points': 1053,
        'countryFlag': '🇨🇦',
        'profilePic': 'https://link.to/profile3.jpg',
      },
      {
        'rank': 4,
        'name': 'Madelyn Dias',
        'points': 590,
        'countryFlag': '🇮🇳',
        'profilePic': 'https://link.to/profile4.jpg',
      },
      {
        'rank': 5,
        'name': 'Zain Vaccaro',
        'points': 448,
        'countryFlag': '🇮🇹',
        'profilePic': 'https://link.to/profile5.jpg',
      },
      // Tambahkan data peringkat lainnya jika diperlukan
    ];

    return rankings.map((user) {
      return Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: 100, // Atur tinggi card di sini
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Nomor peringkat
                Text(
                  "${user['rank']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(width: 10),
                // Foto profil
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user['profilePic'] as String),
                ),
                const SizedBox(width: 10),
                // Informasi user (Nama dan total poin)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [
                      Text(
                        user['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${user['points']} points",
                        style: const TextStyle(
                          color: Color(0xFF858494),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                // Tanda peringkat khusus untuk posisi 1, 2, dan 3
                if (user['rank'] != null)
                  Icon(
                    Icons.emoji_events,
                    color: user['rank'] == 1
                        ? Colors.amber
                        : user['rank'] == 2
                            ? Colors.grey
                            : user['rank'] == 3
                                ? Colors.brown
                                : Colors.transparent,
                  ),
              ],
            ),
          ),
        ),
      );
    }).toList();
    // ignore: dead_code
    return [];
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
