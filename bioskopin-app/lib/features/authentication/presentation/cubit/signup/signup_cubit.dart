// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/features/authentication/data/models/signup/signup_request.dart';
import 'package:bioskopin/features/authentication/domain/usecases/signup.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupCubit(this._signupUseCase) : super(SignupInitial());

  Future<void> onSignup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(SignupLoading());

      final request = SignupRequest(
        fullname: name,
        email: email,
        password: password,
      );

      final response = await _signupUseCase.call(request: request);

      await response.fold(
        (error) {
          if (error.response?.statusCode == HttpStatus.requestTimeout) {
            emit(const SignupFailure(message: errorTimeout));
          } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
            emit(const SignupFailure(message: errorTooManyRequests));
          } else if (error.response?.statusCode ==
              HttpStatus.internalServerError) {
            emit(const SignupFailure(message: errorServer));
          } else if (error.response?.statusCode == HttpStatus.badGateway) {
            emit(const SignupFailure(message: errorBadGateway));
          } else if (error.response?.statusCode ==
              HttpStatus.serviceUnavailable) {
            emit(
              const SignupFailure(
                message: errorServiceUnavailable,
              ),
            );
          } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
            emit(const SignupFailure(message: errorGatewayTimeout));
          } else if (error.response?.statusCode == HttpStatus.conflict) {
            emit(const SignupFailure(message: 'Email sudah terdaftar'));
          } else {
            emit(const SignupFailure(message: errorDefault));
          }
        },
        (response) async {
          emit(SignupSuccess());
        },
      );
    } catch (e) {
      emit(SignupFailure(message: e.toString()));
    }
  }
}
