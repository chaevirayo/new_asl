import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      print('🔐 Starting signup process for email: $email, username: $username');
      
      // Check if username already exists
      print('🔍 Checking if username already exists...');
      final usernameQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        print('❌ Username already exists: $username');
        throw 'Username already exists';
      }
      print('✅ Username is available');

      // Create user with email and password
      print('👤 Creating Firebase Auth user...');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ Firebase Auth user created successfully');

      // Save additional user data to Firestore
      print('💾 Saving user data to Firestore...');
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'progress': {
          'alphabet': 0,
          'basicWords': 0,
          'verbs': 0,
        },
      });
      print('✅ User data saved to Firestore successfully');

      // Save user data locally
      print('💾 Saving user data locally...');
      await _saveUserLocally(userCredential.user!);
      print('✅ User data saved locally successfully');

      print('🎉 Signup completed successfully!');
      return userCredential;
    } catch (e) {
      print('❌ Error during signup: $e');
      print('❌ Error type: ${e.runtimeType}');
      
      // Provide more specific error messages
      if (e is FirebaseAuthException) {
        print('❌ Firebase Auth Error Code: ${e.code}');
        print('❌ Firebase Auth Error Message: ${e.message}');
        
        switch (e.code) {
          case 'weak-password':
            throw 'The password provided is too weak. Please use a stronger password.';
          case 'email-already-in-use':
            throw 'An account already exists for that email address.';
          case 'invalid-email':
            throw 'The email address is not valid.';
          case 'operation-not-allowed':
            throw 'Email/password accounts are not enabled. Please contact support.';
          case 'network-request-failed':
            throw 'Network error. Please check your internet connection and try again.';
          default:
            throw 'Authentication error: ${e.message}';
        }
      } else if (e is FirebaseException) {
        print('❌ Firebase Error Code: ${e.code}');
        print('❌ Firebase Error Message: ${e.message}');
        
        switch (e.code) {
          case 'permission-denied':
            throw 'Database access denied. Please check your Firestore rules.';
          case 'unavailable':
            throw 'Firebase service is currently unavailable. Please try again later.';
          case 'deadline-exceeded':
            throw 'Request timed out. Please try again.';
          default:
            throw 'Firebase error: ${e.message}';
        }
      } else if (e.toString().contains('Username already exists')) {
        throw 'Username already exists. Please choose a different username.';
      } else {
        throw 'An unexpected error occurred: $e';
      }
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Starting signin process for email: $email');
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ Signin successful');

      // Update last login time
      print('💾 Updating last login time...');
      await _firestore.collection('users').doc(userCredential.user!.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
      print('✅ Last login time updated');

      // Save user data locally
      print('💾 Saving user data locally...');
      await _saveUserLocally(userCredential.user!);
      print('✅ User data saved locally');

      return userCredential;
    } catch (e) {
      print('❌ Error during signin: $e');
      
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            throw 'No user found for that email address.';
          case 'wrong-password':
            throw 'Wrong password provided.';
          case 'invalid-email':
            throw 'The email address is not valid.';
          case 'user-disabled':
            throw 'This user account has been disabled.';
          case 'too-many-requests':
            throw 'Too many failed attempts. Please try again later.';
          case 'network-request-failed':
            throw 'Network error. Please check your internet connection.';
          default:
            throw 'Authentication error: ${e.message}';
        }
      } else {
        throw 'An unexpected error occurred: $e';
      }
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      print('🔐 Starting signout process...');
      await _auth.signOut();
      await _clearUserLocally();
      print('✅ Signout completed successfully');
    } catch (e) {
      print('❌ Error during signout: $e');
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      print('🔐 Starting password reset for email: $email');
      await _auth.sendPasswordResetEmail(email: email);
      print('✅ Password reset email sent successfully');
    } catch (e) {
      print('❌ Error during password reset: $e');
      
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            throw 'No user found for that email address.';
          case 'invalid-email':
            throw 'The email address is not valid.';
          case 'network-request-failed':
            throw 'Network error. Please check your internet connection.';
          default:
            throw 'Password reset error: ${e.message}';
        }
      } else {
        throw 'An unexpected error occurred: $e';
      }
    }
  }

  // Save user data locally
  Future<void> _saveUserLocally(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', user.uid);
      await prefs.setString('user_email', user.email ?? '');
      print('✅ Local user data saved: ${user.uid}');
    } catch (e) {
      print('❌ Error saving local user data: $e');
      // Don't throw here as this is not critical
    }
  }

  // Clear user data locally
  Future<void> _clearUserLocally() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('user_email');
      print('✅ Local user data cleared');
    } catch (e) {
      print('❌ Error clearing local user data: $e');
      // Don't throw here as this is not critical
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      print('🔍 Fetching user data for UID: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        print('✅ User data fetched successfully');
        return doc.data();
      } else {
        print('⚠️ User document does not exist');
        return null;
      }
    } catch (e) {
      print('❌ Error fetching user data: $e');
      return null;
    }
  }

  // Update user progress
  Future<void> updateUserProgress({
    required String uid,
    required String category,
    required int progress,
  }) async {
    try {
      print('💾 Updating progress for user $uid, category: $category, progress: $progress');
      await _firestore.collection('users').doc(uid).update({
        'progress.$category': progress,
      });
      print('✅ Progress updated successfully');
    } catch (e) {
      print('❌ Error updating progress: $e');
      rethrow;
    }
  }
}
