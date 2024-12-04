import 'package:flutter/material.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
              _buildTop(context),
              const SizedBox(height: 20),
              _buildUserStatistics(),
              const SizedBox(height: 20),
              _buildMyStatistics(),
              const SizedBox(height: 50),
              _buildQuizList(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
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
                  "Profile",
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
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.person,
            color: Colors.grey[800],
            size: 40,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Nama Pengguna",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
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
            _buildStatisticItem(Icons.star, "SKOR", "590"),
            _buildStatisticItem(Icons.public, "PERINGKAT", "#138"),
            _buildStatisticItem(Icons.autorenew, "MINGGUAN", "#56"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(IconData icon, String label, String value) {
    return SizedBox(
      width: 80, // Set a fixed width for each statistic item
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

  Widget _buildMyStatistics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Statistik Saya",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 37 / 50,
                    strokeWidth: 15,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFFCC822)),
                    backgroundColor: Color.fromARGB(255, 219, 219, 219),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "37/50",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "Kuis dikerjakan",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatisticCard("5", "Kuis dibuat", Icons.edit, Colors.white),
              const SizedBox(width: 20),
              _buildStatisticCard(
                "21", "Kuis benar", Icons.check, const Color(0xFFFCC822)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(
      String value, String label, IconData icon, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color == Colors.white ? Colors.black : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Icon(
                icon,
                color: color == Colors.white ? Colors.black : Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color == Colors.white ? Colors.black : Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizList() {
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
    ];

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
        ...quizzes.map((quiz) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
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
            ),
          );
        }),
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
}
