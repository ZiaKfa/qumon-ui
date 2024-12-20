class ApiUrl {
  static const String baseUrl = 'http://localhost:8000/api';
  static const String registrasi = baseUrl + '/register';
  static const String login = baseUrl + '/login';
  static const String users = baseUrl + '/users';
  static const String quiz = baseUrl + '/quiz';
  static const String kategori = baseUrl + '/kategori';
  static const String leaderboard = baseUrl + '/leaderboard';
  static const String weekly = leaderboard + '/weekly';
  static const String answer = baseUrl + '/answer';
  static const String userAnswer = baseUrl + '/useranswer';
}
