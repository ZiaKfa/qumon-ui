import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A133E),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A133E),
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
        bottomNavigationBar: _buildBottomNavigationBar(),
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
                    // Aksi untuk tombol pengaturan
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
    return Container(
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
          Center(
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
                        const AlwaysStoppedAnimation<Color>(Color(0xFFFCC822)),
                    backgroundColor: Colors.grey,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "37/50",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Kuis dikerjakan",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
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
        }).toList(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Filter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box, color: Colors.blueAccent),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Ranking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
