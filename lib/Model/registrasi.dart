class Registrasi {
  bool? success;
  String? message;
  RegistrasiData? data;

  Registrasi({this.success, this.message, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    return Registrasi(
      success: obj['success'],
      message: obj['message'],
      data: obj['data'] != null ? RegistrasiData.fromJson(obj['data']) : null,
    );
  }
}

class RegistrasiData {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  RegistrasiData(
      {this.id, this.name, this.email, this.createdAt, this.updatedAt});

  factory RegistrasiData.fromJson(Map<String, dynamic> json) {
    return RegistrasiData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
