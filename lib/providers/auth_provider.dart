import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign up
  Future<bool> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      print('🔄 AuthProvider: Starting signup process...');
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );
      print('✅ AuthProvider: Signup successful');
      _setLoading(false);
      return true;
    } catch (e) {
      print('❌ AuthProvider: Signup error caught: $e');
      print('❌ AuthProvider: Error type: ${e.runtimeType}');
      
      // Use the specific error message from AuthService
      String errorMessage = e.toString();
      
      // Remove the "Exception:" prefix if present
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.split('Exception:').last.trim();
      }
      
      // Remove quotes if present
      if (errorMessage.startsWith("'") && errorMessage.endsWith("'")) {
        errorMessage = errorMessage.substring(1, errorMessage.length - 1);
      }
      
      print('❌ AuthProvider: Final error message: $errorMessage');
      _setError(errorMessage);
      _setLoading(false);
      return false;
    }
  }

  // Sign in
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      print('🔄 AuthProvider: Starting signin process...');
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('✅ AuthProvider: Signin successful');
      _setLoading(false);
      return true;
    } catch (e) {
      print('❌ AuthProvider: Signin error caught: $e');
      print('❌ AuthProvider: Error type: ${e.runtimeType}');
      
      // Use the specific error message from AuthService
      String errorMessage = e.toString();
      
      // Remove the "Exception:" prefix if present
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.split('Exception:').last.trim();
      }
      
      // Remove quotes if present
      if (errorMessage.startsWith("'") && errorMessage.endsWith("'")) {
        errorMessage = errorMessage.substring(1, errorMessage.length - 1);
      }
      
      print('❌ AuthProvider: Final error message: $errorMessage');
      _setError(errorMessage);
      _setLoading(false);
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Update user progress
  Future<void> updateProgress({
    required String category,
    required int progress,
  }) async {
    if (_user != null) {
      try {
        await _authService.updateUserProgress(
          uid: _user!.uid,
          category: category,
          progress: progress,
        );
      } catch (e) {
        _setError(e.toString());
      }
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
