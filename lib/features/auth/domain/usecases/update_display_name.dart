import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';

class UpdateDisplayName {
  final AuthRepository repository;

  UpdateDisplayName(this.repository);

  Future<void> call(String name) async {
    return await repository.updateDisplayName(name);
  }
}
