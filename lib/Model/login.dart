class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    // Check if login was successful
    if (obj['success'] == true) {
      return Login(
        code: obj['code'],
        status: obj['success'],
        token: obj['data']['token'],  // Assuming token exists in the response
        userID: obj['data']['id'],    // Get the user ID from 'data'
        userEmail: obj['data']['email'],  // Get the user email from 'data'
      );
    } else {
      return Login(
        code: obj['code'],
        status: obj['success'],
      );
    }
  }
}
