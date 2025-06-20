class UserModel {
  final int id;
  final String email;
  final String name;
  final String? profileImage;
  final String? token;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  // Optional fields for local profile display/editing
  final String? phone;
  final String? bio;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.token,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      email: json['email'] as String,
      name: json['name'] as String,
      profileImage: json['profile_image'] as String?,
      token: json['token'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image': profileImage,
      'token': token,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'phone': phone,
      'bio': bio,
    };
  }

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? profileImage,
    String? token,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? phone,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      token: token ?? this.token,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }
}
