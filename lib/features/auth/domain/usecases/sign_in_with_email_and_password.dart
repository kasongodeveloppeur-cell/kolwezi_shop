import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<UserCredential> call(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}
