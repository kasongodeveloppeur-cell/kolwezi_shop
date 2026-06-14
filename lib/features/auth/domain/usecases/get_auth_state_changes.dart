
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';

class GetAuthStateChanges {
  final AuthRepository repository;

  GetAuthStateChanges(this.repository);

  Stream<User?> call() {
    return repository.authStateChanges;
  }
}
