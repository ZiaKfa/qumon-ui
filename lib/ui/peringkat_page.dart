import 'package:flutter/material.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';
import 'dart:convert';

class PeringkatPage extends StatefulWidget {
  const PeringkatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PeringkatPageState createState() => _PeringkatPageState();
}

class _PeringkatPageState extends State<PeringkatPage> {
  bool isWeeklySelected = true;
  List<dynamic> leaderboard = [];
  List<dynamic> weeklyLeaderboard = [];

  @override
  void initState() {
    super.initState();
    fetchWeeklyRankingData();    
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
              _buildTop(context),
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
      padding: const EdgeInsets.only(
          top: 16.0, bottom: 16.0), // Menambahkan margin atas dan bawah
      child: SizedBox(
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
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isWeeklySelected = true;
                          removeWeeklyRankingData();
                          fetchWeeklyRankingData();
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
                              color: isWeeklySelected
                                  ? Colors.black
                                  : Colors.white,
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
                          removeRankingData();
                          fetchRankingData();
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
                              color: !isWeeklySelected
                                  ? Colors.black
                                  : Colors.white,
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
    List<dynamic> rankings = isWeeklySelected ? weeklyLeaderboard : leaderboard;
    

    return rankings.map((user) {
      int rank = rankings.indexOf(user) + 1;
      user['rank'] = rank;
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
                const SizedBox(width: 10),
                // Informasi user (Nama dan total poin)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [
                      Text(
                        user['user'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${user['total_correct_answer']} points",
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
        currentIndex: 3,
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

  Future<void> fetchRankingData() async {
    String url = ApiUrl.leaderboard;
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    var response = await Api().get(url,basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    setState(() {
      leaderboard = jsonObj['data'] as List<dynamic>;
    });
  }
  

  Future<void> fetchWeeklyRankingData() async {
    String url = ApiUrl.weekly;
    var userName = await UserInfo.getName();
    var password = await UserInfo.getPassword();
    var basicAuth = base64Encode(utf8.encode('$userName:$password'));
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    setState(() {
      weeklyLeaderboard = jsonObj['data'] as List<dynamic>;
    });
  }

  Future<void> removeRankingData() async {
    setState(() {
      leaderboard = [];
    });
  }

  Future<void> removeWeeklyRankingData() async {
    setState(() {
      weeklyLeaderboard = [];
    });
  }
}