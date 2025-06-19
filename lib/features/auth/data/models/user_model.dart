class UserModel {
  final int id;
  final String email;
  final String name;
  final String? profileImage;
  final String token;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      email: json['email'] as String,
      name: json['name'] as String,
      profileImage: json['profile_image'] as String?,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image': profileImage,
      'token': token,
    };
  }
}
