import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';

class CreateUserWithEmailAndPassword {
  final AuthRepository repository;

  CreateUserWithEmailAndPassword(this.repository);

  Future<UserCredential> call(String email, String password) {
    return repository.createUserWithEmailAndPassword(email, password);
  }
}
