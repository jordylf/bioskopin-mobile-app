// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/features/authentication/domain/usecases/get_user.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetUserUseCase _getUserUseCase;

  SplashCubit(this._getUserUseCase) : super(SplashInitial());

  Future<void> onSplashStart() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    final user = await _getUserUseCase.call();

    if (user != null) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToLogin());
    }
  }
}
