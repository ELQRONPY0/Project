import 'package:ai_tumor_detect/features/auth/data/models/user_model.dart';
import 'package:ai_tumor_detect/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _loading = false;
  String? _error;
  bool _isInitialized = false;

  final AuthRepository _authRepository;

  UserProvider(this._authRepository);

  UserModel? get user => _user;
  bool get isLoading => _loading;
  String? get error => _error;
  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _user != null;

  Future<void> init() async {
    await _authRepository.initPrefs();
    await loadUser();
    _isInitialized = true;
    notifyListeners();
  }

  /// Load current user from backend
  Future<void> loadUser() async {
    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (err) {
        _error = err.toString();
        _user = null;
      },
      (userData) {
        _user = userData;
        _error = null;
      },
    );

    _loading = false;
    notifyListeners();
  }

  /// Update user fields locally (and optionally on backend)
  Future<void> updateUser({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? profileImage,
  }) async {
    if (_user == null) return;

    _user = _user!.copyWith(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      profileImage: profileImage ?? _user!.profileImage,
    );

    notifyListeners();

    // Optional: update on backend
    // final result = await _authRepository.updateUser(_user!);
    // result.fold(
    //   (err) {
    //     _error = err.toString();
    //     notifyListeners();
    //   },
    //   (updatedUser) {
    //     _user = updatedUser;
    //     notifyListeners();
    //   },
    // );
  }

  Future<void> setUser(UserModel user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> clearUser() async {
    _user = null;

    // Clear user-specific diagnosis data from local storage.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('diagnosisResult');
    await prefs.remove('selectedImagePath');
    await prefs.remove('hasDiagnosed');

    // Also clear the auth token from repository/storage.
    await _authRepository.logout();

    notifyListeners();
  }
}
