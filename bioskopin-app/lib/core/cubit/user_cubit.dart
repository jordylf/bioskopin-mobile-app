// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/get_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/save_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase _getUserUseCase;
  final SaveUserUseCase _saveUserUseCase;

  UserCubit(this._getUserUseCase, this._saveUserUseCase)
      : super(UserState(name: '', email: '')) {
    onLoadUser();
  }

  Future<void> onLoadUser() async {
    final user = await _getUserUseCase.call();

    emit(
      UserState(
        name: user?.name ?? '',
        email: user?.email ?? '',
      ),
    );
  }

  Future<void> onUpdateUser({
    required String name,
    required String email,
    required String about,
  }) async {
    final oldUser = await _getUserUseCase.call();

    final user = User(
      name: name,
      email: email,
      token: oldUser?.token ?? '',
    );

    await _saveUserUseCase.call(request: user);

    emit(
      UserState(name: name, email: email),
    );
  }
}
