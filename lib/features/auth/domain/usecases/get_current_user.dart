
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  User? call() {
    return repository.getCurrentUser();
  }
}
