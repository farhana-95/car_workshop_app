import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/models/users.dart';
import 'package:car_workshop_app/service/firebase.dart';

final authControllerProvider = StateNotifierProvider<AuthController, UserModel?>((ref) {
  final firebaseService = FirebaseService();
  return AuthController(firebaseService);
});

class AuthController extends StateNotifier<UserModel?> {
  final FirebaseService _firebaseService;

  AuthController(this._firebaseService) : super(null);

  UserModel? get user => state;

  Future<void> signUp(String email, String password, String role, String name) async {
    final user = await _firebaseService.signUpUser(email, password, role, name);
    state = user;
  }

  Future<void> logIn(String email, String password) async {
    final user = await _firebaseService.logInUser(email, password);
    state = user;
  }

  Future<List<UserModel>> fetchMechanics() async {
    return await _firebaseService.fetchMechanics();
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
    state = null;
  }
}

