import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Homepage();
          }));
        } else if (index == 1) {
          // Tambahkan navigasi ke halaman lain
        }
      },
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
          icon: Icon(Icons.add_box),
          label: 'Tambah',
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}
