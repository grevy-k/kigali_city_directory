import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _service = AuthService();

  User? user;
  AppUser? profile;

  bool isLoading = true;
  String? error;

  StreamSubscription<User?>? _sub;

  void init() {
    _sub?.cancel();
    _sub = _service.authChanges().listen((u) async {
      user = u;
      error = null;

      if (u != null) {
        profile = await _service.fetchProfile(u.uid);
      } else {
        profile = null;
      }

      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      await _service.signUp(email: email, password: password, displayName: name);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      await _service.login(email: email, password: password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async => _service.logout();

  Future<void> resendVerification() async => _service.resendVerification();

  Future<void> refreshUser() async {
    await _service.reloadUser();
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}