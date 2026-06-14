import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:myapp/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:myapp/features/auth/domain/usecases/create_user_with_email_and_password.dart';
import 'package:myapp/features/auth/domain/usecases/sign_out.dart';
import 'package:myapp/features/auth/domain/usecases/update_display_name.dart';
import 'package:myapp/features/user/data/services/user_service.dart';

class AuthProvider with ChangeNotifier {
  final GetAuthStateChanges getAuthStateChanges;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final CreateUserWithEmailAndPassword createUserWithEmailAndPassword;
  final SignOut signOut;
  final UpdateDisplayName updateDisplayNameUseCase;
  final UserService userService;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthProvider({
    required this.getAuthStateChanges,
    required this.signInWithEmailAndPassword,
    required this.createUserWithEmailAndPassword,
    required this.signOut,
    required this.updateDisplayNameUseCase,
    required this.userService,
  }) {
    getAuthStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final userCredential = await createUserWithEmailAndPassword(email, password);
      if (userCredential.user != null) {
        await userService.createUser(userCredential.user!);
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await signOut();
  }

  Future<void> updateDisplayName(String name) async {
    try {
      await updateDisplayNameUseCase(name);
      _user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
