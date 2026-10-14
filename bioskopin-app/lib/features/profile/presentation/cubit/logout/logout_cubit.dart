// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/features/authentication/domain/usecases/remove_user.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final RemoveUserUseCase _removeUserUseCase;

  LogoutCubit(this._removeUserUseCase) : super(LogoutInitial());

  Future<void> onLogout() async {
    try {
      emit(LogoutLoading());

      _removeUserUseCase.call();

      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
}
