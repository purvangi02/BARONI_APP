import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(FirebaseAuthException e) onVerificationFailed,
    void Function(PhoneAuthCredential credential)? onVerificationCompleted,
    void Function()? onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted ?? (_) {},
      verificationFailed: onVerificationFailed,
      codeSent: (verificationId, resendToken) =>
          onCodeSent(verificationId, resendToken),
      codeAutoRetrievalTimeout: (verificationId) {
        if (onCodeAutoRetrievalTimeout != null) onCodeAutoRetrievalTimeout();
      },
    );
  }

  Future<UserCredential> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _auth.signInWithCredential(credential);
  }

  // Create user with phone authentication
  Future<UserCredential> createUserWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _auth.signInWithCredential(credential);
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Save user profile to Firestore
  Future<void> saveUserProfile(Map<String, dynamic> userData) async {
    try {
      final userDoc = _firestore.collection('users').doc(userData['uid']);
      await userDoc.set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Error saving user profile: $e');
      rethrow;
    }
  }

  // Check if phone number exists
  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking phone number: $e');
      return false;
    }
  }

  // Authenticate user with phone and password
  Future<Map<String, dynamic>?> authenticateUser(
      String phoneNumber, String password) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        if (userData['password'] == password) {
          return userData;
        }
      }
      return null;
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }

  // Update user password
  Future<bool> updateUserPassword(
      String phoneNumber, String newPassword) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first.reference;
        await userDoc.update({
          'password': newPassword,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  // Get user data by phone number
  Future<Map<String, dynamic>?> getUserByPhone(String phoneNumber) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      }
      return null;
    } catch (e) {
      print('Error getting user by phone: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      await userDoc.update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }
}

