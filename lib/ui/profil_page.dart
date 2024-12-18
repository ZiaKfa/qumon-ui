import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qumon/bloc/kategori_bloc.dart';
import 'package:qumon/bloc/logout_bloc.dart';
import 'package:qumon/helpers/api.dart';
import 'package:qumon/helpers/api_url.dart';
import 'package:qumon/helpers/user_info.dart';
import 'package:qumon/ui/kuis_list_page.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/login_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Future<List> kategoriList;
  List<dynamic> leaderboard = [];
  List<dynamic> weeklyLeaderboard = [];
  @override
  void initState() {
    super.initState();
    // Mengambil data kategori saat halaman dimuat
    fetchRankingData();
    fetchWeeklyRankingData();
    kategoriList = KategoriBloc().getKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              FutureBuilder<Widget>(
                future: _buildTop(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildUserStatistics(),
              const SizedBox(height: 20),
              // _buildMyStatistics(),
              // const SizedBox(height: 50),
              _buildQuizList(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Future<Widget> _buildTop(BuildContext context) async {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
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
                  "Profil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text(
                            'Keluar',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            'Apakah kamu yakin ingin keluar?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                await LogoutBloc.logout();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                'Keluar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(height: 15),
        FutureBuilder<String?>(
          future: UserInfo.getName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              );
            } else {
              return Text(
                snapshot.data ?? 'Unknown',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildUserStatistics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFCC822),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatisticItem(
                Icons.star, "SKOR", "305"),
            _buildStatisticItem(Icons.public, "PERINGKAT", "#1"),
            _buildStatisticItem(
                Icons.autorenew, "MINGGUAN", "#3"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(IconData icon, String label, String value) {
    return Flexible(
      child: Column(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildMyStatistics() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const SizedBox(height: 30),
  //         const Text(
  //           "Statistik Saya",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 18,
  //             fontFamily: 'Poppins',
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 30),
  //         const Center(
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               SizedBox(
  //                 width: 120,
  //                 height: 120,
  //                 child: CircularProgressIndicator(
  //                   value: 37 / 50,
  //                   strokeWidth: 15,
  //                   valueColor:
  //                       AlwaysStoppedAnimation<Color>(Color(0xFFFCC822)),
  //                   backgroundColor: Color.fromARGB(255, 219, 219, 219),
  //                 ),
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     "37/50",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: 'Poppins',
  //                     ),
  //                   ),
  //                   Text(
  //                     "Kuis dikerjakan",
  //                     style: TextStyle(
  //                       color: Colors.white70,
  //                       fontSize: 12,
  //                       fontFamily: 'Poppins',
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 40),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _buildStatisticCard("5", "Kuis dibuat", Icons.edit, Colors.white),
  //             const SizedBox(width: 20),
  //             _buildStatisticCard(
  //                 "21", "Kuis benar", Icons.check, const Color(0xFFFCC822)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStatisticCard(
  //     String value, String label, IconData icon, Color color) {
  //   return Container(
  //     width: 140,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               value,
  //               style: TextStyle(
  //                 color: color == Colors.white ? Colors.black : Colors.white,
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Poppins',
  //               ),
  //             ),
  //             Icon(
  //               icon,
  //               color: color == Colors.white ? Colors.black : Colors.white,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             color: color == Colors.white ? Colors.black : Colors.white,
  //             fontSize: 14,
  //             fontFamily: 'Poppins',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildQuizList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Kuis Saya",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<List>(
          future: kategoriList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada kategori',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return Column(
                children: snapshot.data!.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Icon(
                          Icons.category,
                          color: Colors.blue[700],
                          size: 40,
                        ),
                        title: Text(
                          category['name'] ?? 'Kategori Tidak Dikenal',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: const Text(
                          "Kategori Quiz",
                          style: TextStyle(
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
                          // You can add navigation or action when a category is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KuisListPage(
                                  category["name"], category["id"]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
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
        currentIndex: 4,
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

  Future<void> fetchRankingData() async {
    var basicAuth = await UserInfo.getAuth();
    String url = ApiUrl.leaderboard;
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    setState(() {
      leaderboard = jsonObj['data'] as List<dynamic>;
    });
  }

  Future<void> fetchWeeklyRankingData() async {
    String url = ApiUrl.weekly;
    var basicAuth = await UserInfo.getAuth();
    var response = await Api().get(url, basicAuth);
    var jsonObj = jsonDecode(response.body);
    print(jsonObj);
    setState(() {
      weeklyLeaderboard = jsonObj['data'] as List<dynamic>;
    });
  }

  int getUserRank() {
    // Cari indeks pengguna dalam leaderboard
    var userRank = leaderboard.indexWhere((element) {
      return element['user'] == UserInfo.getName();
    });

    // Jika pengguna tidak ditemukan, kembalikan -1 sebagai default
    return userRank >= 0 ? userRank + 1 : -1;
  }

  int getUserWeeklyRank() {
    // Cari indeks pengguna dalam weeklyLeaderboard
    var userRank = weeklyLeaderboard.indexWhere((element) {
      return element['user'] == UserInfo.getName();
    });

    // Jika pengguna tidak ditemukan, kembalikan -1 sebagai default
    return userRank >= 0 ? userRank + 1 : -1;
  }

  int getUserCorrectAnswer() {
    try {
      // Cari pengguna di leaderboard dan dapatkan jumlah jawaban benar
      var user = leaderboard.firstWhere((element) {
        return element['user'] == UserInfo.getName();
      });

      return user['total_correct_answer'] ?? 0;
    } catch (e) {
      // Jika pengguna tidak ditemukan, kembalikan 0 sebagai default
      return 0;
    }
  }
}
