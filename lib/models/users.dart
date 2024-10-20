class UserModel {
  final String? uid;
  final String? email;
  final String? password;
  final String? role;

  UserModel({
    this.uid,
    this.email,
    this.password,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 'admin',
    );
  }
}