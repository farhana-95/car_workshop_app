import 'package:car_workshop_app/models/booking_model.dart';
import 'package:car_workshop_app/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUpUser(
      String email, String password, String role) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        role: role,
      );

      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('Created the user');
      return user;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }

  Future<UserModel?> logInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      print('logged in ');
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Log in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<BookingModel>> fetchBookings() async {
    try {
      final querySnapshot = await _firestore.collection('bookings').get();
      final data = querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
      print('BOOK DATA $data');
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> addBooking(Map<String, dynamic> bookingData) async {
    try {
      await _firestore.collection('bookings').add(bookingData);
    } catch (e) {
      print('Error Adding Data $e');
    }
  }

  Future<List<UserModel>> fetchMechanics() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role',
              isEqualTo:
                  'mechanic') // Assuming 'role' is the field for user roles
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching mechanics: $e');
      return [];
    }
  }
}
