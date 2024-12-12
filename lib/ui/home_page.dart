import 'package:flutter/material.dart';
import 'package:qumon/bloc/quiz_bloc.dart';
import 'package:qumon/ui/filter_kuis_page.dart';
import 'package:qumon/ui/peringkat_page.dart';
import 'package:qumon/ui/profil_page.dart';
import 'package:qumon/ui/tambah_kuis_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String?>> quizData = [];
  List<Map<String, String?>> displayedQuizData = [];
  final int questionsPerLoad = 5;
  int currentLoadedQuestions = 0;
  bool isLoading = false;
  bool hasMoreQuestions = true;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadQuizData();

    // Add listener to handle automatic loading
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    // Check if we're near the end of the current list and there are more questions
    if (_pageController.position.pixels >=
            _pageController.position.maxScrollExtent - 100 &&
        hasMoreQuestions &&
        !isLoading) {
      _loadMoreQuestions();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadQuizData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var quiz = QuizBloc().getQuiz();
      quiz.then((value) {
        setState(() {
          // Simpan semua data quiz
          quizData = value.data
                  ?.map((quiz) => {
                        "user": quiz.user,
                        "category": quiz.category,
                        "question": quiz.question,
                      })
                  .toList() ??
              [];

          // Muat pertanyaan pertama
          _loadMoreQuestions();

          isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading quiz data: $e');
    }
  }

  void _loadMoreQuestions() {
    print('Loading more questions...');
    // Hitung mulai dan akhir pertanyaan
    int startIndex = currentLoadedQuestions;
    int endIndex = startIndex + questionsPerLoad;

    // Pastikan tidak melebihi total pertanyaan
    endIndex = endIndex > quizData.length ? quizData.length : endIndex;

    // Tambahkan pertanyaan baru
    List<Map<String, String?>> newQuestions =
        quizData.sublist(startIndex, endIndex);

    setState(() {
      displayedQuizData.addAll(newQuestions);
      currentLoadedQuestions = endIndex;

      // Periksa apakah masih ada pertanyaan
      hasMoreQuestions = currentLoadedQuestions < quizData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      displayedQuizData.length + (hasMoreQuestions ? 1 : 0),
                  itemBuilder: (context, index) {
                    // If it's the last item and we have more questions, show loading
                    if (index == displayedQuizData.length && hasMoreQuestions) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    // Regular quiz item
                    final data = displayedQuizData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data["user"] ?? "",
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
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Aksi saat tombol "Cek" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFC107),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0),
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
              ),
            ],
          ),
          // Remove the separate Loading indicator as it's now integrated
          if (isLoading && displayedQuizData.isEmpty)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
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
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}
