// Project imports:
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/core/usecases/usecase.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';

class GetUserUseCase implements UseCase<NoParams, User?> {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  @override
  Future<User?> call({NoParams? request}) async {
    return await _authRepository.getUser();
  }
}
