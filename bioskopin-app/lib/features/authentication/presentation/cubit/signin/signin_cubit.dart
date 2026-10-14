// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/features/authentication/data/models/signin/signin_request.dart';
import 'package:bioskopin/features/authentication/domain/usecases/save_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/signin.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUseCase _signinUseCase;
  final SaveUserUseCase _saveUserUseCase;

  SigninCubit(this._signinUseCase, this._saveUserUseCase)
      : super(SigninInitial());

  Future<void> onSignin({
    required String email,
    required String password,
  }) async {
    try {
      emit(SigninLoading());

      final request = SigninRequest(email: email, password: password);

      final response = await _signinUseCase.call(request: request);

      await response.fold(
        (error) {
          if (error.response?.statusCode == HttpStatus.unauthorized) {
            emit(
              const SigninFailure(message: 'Email atau password salah'),
            );
          } else if (error.response?.statusCode == HttpStatus.requestTimeout) {
            emit(const SigninFailure(message: errorTimeout));
          } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
            emit(const SigninFailure(message: errorTooManyRequests));
          } else if (error.response?.statusCode ==
              HttpStatus.internalServerError) {
            emit(const SigninFailure(message: errorServer));
          } else if (error.response?.statusCode == HttpStatus.badGateway) {
            emit(const SigninFailure(message: errorBadGateway));
          } else if (error.response?.statusCode ==
              HttpStatus.serviceUnavailable) {
            emit(
              const SigninFailure(
                message: errorServiceUnavailable,
              ),
            );
          } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
            emit(const SigninFailure(message: errorGatewayTimeout));
          } else {
            emit(const SigninFailure(message: errorDefault));
          }
        },
        (response) async {
          final user = User(
            name: response.data?.fullname ?? '',
            email: response.data?.email ?? '',
            token: response.token ?? '',
          );

          await _saveUserUseCase.call(request: user);

          emit(SigninSuccess());
        },
      );
    } catch (e) {
      emit(SigninFailure(message: e.toString()));
    }
  }
}
