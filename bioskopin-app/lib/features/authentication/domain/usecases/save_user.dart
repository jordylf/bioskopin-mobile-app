// Project imports:
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class SaveUserUseCase implements UseCase<User, void> {
  final AuthRepository _authRepository;

  SaveUserUseCase(this._authRepository);

  @override
  Future<void> call({User? request}) async {
    return await _authRepository.saveUser(request!);
  }
}
