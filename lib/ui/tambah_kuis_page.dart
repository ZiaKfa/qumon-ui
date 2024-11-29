import 'package:flutter/material.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';

class TambahKuisPage extends StatelessWidget {
  const TambahKuisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A133E), // Sesuai dengan tema
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Soal",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategori",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Math", child: Text("Math")),
                DropdownMenuItem(value: "Science", child: Text("Science")),
                DropdownMenuItem(value: "History", child: Text("History")),
              ],
              onChanged: (value) {
                // Aksi saat kategori dipilih
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Soal",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Jawaban",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Aksi untuk tambah soal
                  },
                  child: const Text(
                    "Tambah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Aksi untuk menyimpan soal
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          // Aksi untuk menu Filter Kuis
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FilterKuisPage();
          }));
        } else if (index == 2) {
          // Aksi untuk menu Tambah
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TambahKuisPage();
          }));
        } else if (index == 3) {
          // Aksi untuk menu Ranking
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PeringkatPage();
          }));
        } else if (index == 4) {
          // Aksi untuk menu Profil
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ProfilPage();
          }));
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
