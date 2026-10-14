// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bioskopin/core/constants/constants.dart';
import 'package:bioskopin/core/entities/user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/get_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/save_user.dart';
import 'package:bioskopin/features/profile/data/models/edit_profile_request.dart';
import 'package:bioskopin/features/profile/domain/usecases/edit_profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final GetUserUseCase _getUserUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final SaveUserUseCase _saveUserUseCase;

  EditProfileCubit(
    this._getUserUseCase,
    this._editProfileUseCase,
    this._saveUserUseCase,
  ) : super(EditProfileInitial());

  Future<void> onEditProfile({
    required String name,
    required String email,
  }) async {
    try {
      emit(EditProfileLoading());

      final user = await _getUserUseCase.call();

      final request = EditProfileRequest(
        fullname: name,
        email: email,
      );

      final response = await _editProfileUseCase.call(request: request);

      response.fold(
        (error) {
          if (error.response?.statusCode == HttpStatus.requestTimeout) {
            emit(const EditProfileFailure(message: errorTimeout));
          } else if (error.response?.statusCode == HttpStatus.tooManyRequests) {
            emit(const EditProfileFailure(message: errorTooManyRequests));
          } else if (error.response?.statusCode ==
              HttpStatus.internalServerError) {
            emit(const EditProfileFailure(message: errorServer));
          } else if (error.response?.statusCode == HttpStatus.badGateway) {
            emit(const EditProfileFailure(message: errorBadGateway));
          } else if (error.response?.statusCode ==
              HttpStatus.serviceUnavailable) {
            emit(
              const EditProfileFailure(
                message: errorServiceUnavailable,
              ),
            );
          } else if (error.response?.statusCode == HttpStatus.gatewayTimeout) {
            emit(const EditProfileFailure(message: errorGatewayTimeout));
          } else if (error.response?.statusCode == HttpStatus.conflict) {
            emit(const EditProfileFailure(message: 'Email sudah digunakan'));
          } else {
            emit(const EditProfileFailure(message: errorDefault));
          }
        },
        (success) async {
          emit(EditProfileSuccess());

          final data = User(
            name: name,
            email: email,
            token: user?.token ?? '',
          );

          await _saveUserUseCase.call(request: data);
        },
      );
    } catch (e) {
      emit(EditProfileFailure(message: e.toString()));
    }
  }
}
