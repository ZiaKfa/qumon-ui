import 'package:flutter/material.dart';
import 'package:qumon/bloc/answer_bloc.dart';
import 'package:qumon/bloc/kategori_bloc.dart';
import 'package:qumon/bloc/quiz_bloc.dart';
import 'package:qumon/helpers/user_info.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/widget/sukses.dart';

class TambahKuisPage extends StatefulWidget {
  const TambahKuisPage({Key? key}) : super(key: key);

  @override
  _TambahKuisPageState createState() => _TambahKuisPageState();
}

class _TambahKuisPageState extends State<TambahKuisPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int? _selectedKategori;
  final _soalController = TextEditingController();
  final _jawabanController = TextEditingController();
  late Future<List> kategori;
  @override
  void dispose() {
    _soalController.dispose();
    _jawabanController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    kategori = KategoriBloc().getKategori();
  }

  Future<void> _tambahSoal() async {
    if (_formKey.currentState!.validate()) {
      final userId = await UserInfo.getId();
      print('User ID: $userId type: ${userId.runtimeType}');
      final int kategori = _selectedKategori ?? 0;
      final String soal = _soalController.text.trim();
      final String jawaban = _jawabanController.text.trim().toLowerCase();

      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      QuizBloc().addNewQuiz(userId, kategori, soal).then((value) {
        var id = value.data?.id;
        setState(() {
          isLoading = false;
        });
        AnswerBloc().addAnswer(id, jawaban).then((value) {
          print(value);
        });
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessModal(
            title: "Berhasil",
            message: 'Soal berhasil ditambahkan!',
            onClose: () {
              setState(() {
                _selectedKategori = null;
                _soalController.clear();
                _jawabanController.clear();
              });
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var isPrivate = false;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  "Tambah Soal",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                            FutureBuilder<List>(
                              future: kategori,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    items: [],
                                    onChanged: null,
                                    validator: (value) =>
                                        value == null ? 'Pilih kategori' : null,
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text('Error loading categories');
                                } else {
                                  return DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    value: _selectedKategori,
                                    items: [
                                      for (var item in snapshot.data!)
                                        DropdownMenuItem<int>(
                                          value: item['id'],
                                          child: Text(item['name']),
                                        ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedKategori = value;
                                      });
                                    },
                                    validator: (value) =>
                                        value == null ? 'Pilih kategori' : null,
                                  );
                                }
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
                            TextFormField(
                              controller: _soalController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Masukkan soal'
                                      : null,
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
                            TextFormField(
                              controller: _jawabanController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Masukkan jawaban'
                                      : null,
                            ),
                            const SizedBox(height: 16),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFC107),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _tambahSoal();
                                    }
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
        currentIndex: 2,
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
          boxShadow: [
            BoxShadow(
              color: Colors.amberAccent.withOpacity(0.5),
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
