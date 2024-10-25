class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? role;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 'admin',
    );
  }
}