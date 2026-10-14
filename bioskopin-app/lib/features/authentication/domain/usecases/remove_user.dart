// Project imports:
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class RemoveUserUseCase implements UseCase<NoParams, void> {
  final AuthRepository _authRepository;

  RemoveUserUseCase(this._authRepository);

  @override
  Future<void> call({NoParams? request}) async {
    return await _authRepository.removeUser();
  }
}
