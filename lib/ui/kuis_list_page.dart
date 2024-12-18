import 'package:flutter/material.dart';
import 'package:qumon/bloc/quiz_bloc.dart';
import 'package:qumon/helpers/user_info.dart';
import 'package:qumon/ui/edit_kuis_page.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/home_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';
import 'package:qumon/widget/konfirmasi.dart';


class KuisListPage extends StatefulWidget {
  final String category;
  final int categoryId;

  const KuisListPage(this.category, this.categoryId, {Key? key})
      : super(key: key);

  @override
  _KuisListPageState createState() => _KuisListPageState();
}

class _KuisListPageState extends State<KuisListPage> {
  Future<List<Map<String, dynamic>>> quizList = Future.value([]);

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Mengambil data kategori saat halaman dimuat
    getQuizList(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A133E),
      appBar: AppBar(
        title: const Text(
          'Kuis Saya',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF1A133E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildQuizList(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildQuizList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<List>(
            future: quizList,
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
                    'Tidak ada Kuis',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final kuis = snapshot.data![index];
                    return Card(
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
                          kuis['question'] ?? 'Kategori Tidak Dikenal',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: Text(
                          kuis['category'] ?? 'Kategori Tidak Dikenal',
                          style: const TextStyle(
                            color: Color(0xFF858494),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Color(0xFF6A5AE0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditKuisPage(quizId: int.parse(kuis["id"]))));
                              },
                            ),
                            IconButton(
                              icon: const Icon( 
                                Icons.delete,
                                size: 20,
                                color: Color(0xFF6A5AE0),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmModal(
                                      title: 'Hapus Kuis',
                                      message: 'Apakah Anda yakin ingin menghapus kuis ini?',
                                      onConfirm: () async {
                                        var quizBloc = QuizBloc();
                                        await quizBloc.deleteQuiz(int.parse(kuis["id"]), widget.categoryId, kuis["question"]);
                                        Navigator.pop(context);
                                        getQuizList(widget.categoryId);
                                      },
                                      onCancel: () => Navigator.pop(context),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
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

  Future<void> getQuizList(int categoryId) async {
    var userId = await UserInfo.getId();
    setState(() {
      isLoading = true;
    });

    try {
      quizList = QuizBloc()
          .getQuizByUserAndCategory(userId!, categoryId)
          .then((value) {
        return value.data
                ?.map((quiz) => {
                      "id": quiz.id.toString(),
                      "user": quiz.user,
                      "category": quiz.category,
                      "question": quiz.question,
                      "answer": quiz.answer,
                    })
                .toList() ??
            [];
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
}
