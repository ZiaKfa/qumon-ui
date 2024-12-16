class Kategori {
  final int id;
  final String name;

  // Constructor
  Kategori({required this.id, required this.name});

  // Method untuk membuat objek Kategori dari JSON
  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: int.parse(json['id'].toString()),
      name: json['name'],
    );
  }

  // Method untuk mengonversi objek Kategori ke dalam format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CategoryResponse {
  bool? success;
  String? message;
  List<Kategori>? data;

  CategoryResponse({this.success, this.message, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Kategori> dataList = list.map((i) => Kategori.fromJson(i)).toList();
    return CategoryResponse(
      success: json['success'],
      message: json['message'],
      data: dataList,
    );
  }
}
