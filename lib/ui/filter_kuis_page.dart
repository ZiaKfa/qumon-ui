import 'package:flutter/material.dart';

class FilterKuisPage extends StatelessWidget {
  const FilterKuisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A133E),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A133E),
        body: Stack(children: [
          Positioned(top: 40, child: _buildTop(context)),
          Positioned(bottom: 0, child: _buildBottom(context)),
        ]),
        bottomNavigationBar: _buildBottomNavigationBar(),
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
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Center(
                  child: const Text(
                    "Filter Kuis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                    ),
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
              width: MediaQuery.of(context).size.width *
                  0.8, // Reduce width to 80% of screen width
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Kategori',
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFF6A5AE0)),
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    bool showAllQuizzes = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
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
