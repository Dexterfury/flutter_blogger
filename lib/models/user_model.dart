class UserModel {
  int id;
  String name;
  String email;
  String imageUrl;

  // constructor
  UserModel({
    required this.id,
    required this.name,
    this.email = 'dexterfury@test.com',
    required this.imageUrl,
  });

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
