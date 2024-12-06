class Kategori {
  final int id;
  final String name;

  // Constructor
  Kategori({required this.id, required this.name});

  // Method untuk membuat objek Kategori dari JSON
  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
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
