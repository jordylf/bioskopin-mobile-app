// Package imports:
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bioskopin/core/cubit/user_cubit.dart';
import 'package:bioskopin/features/app_startup/presentation/cubit/splash_cubit.dart';
import 'package:bioskopin/features/authentication/data/datasources/local/auth_local_service.dart';
import 'package:bioskopin/features/authentication/data/datasources/remote/auth_api_service.dart';
import 'package:bioskopin/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:bioskopin/features/authentication/domain/repositories/auth_repository.dart';
import 'package:bioskopin/features/authentication/domain/usecases/get_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/remove_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/save_user.dart';
import 'package:bioskopin/features/authentication/domain/usecases/signin.dart';
import 'package:bioskopin/features/authentication/domain/usecases/signup.dart';
import 'package:bioskopin/features/authentication/presentation/cubit/signin/signin_cubit.dart';
import 'package:bioskopin/features/authentication/presentation/cubit/signup/signup_cubit.dart';
import 'package:bioskopin/features/booking/data/datasources/remote/booking_api_service.dart';
import 'package:bioskopin/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bioskopin/features/booking/domain/repositories/booking_repository.dart';
import 'package:bioskopin/features/booking/domain/usecases/get_booking.dart';
import 'package:bioskopin/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bioskopin/features/film/data/datasources/remote/film_api_service.dart';
import 'package:bioskopin/features/film/data/repositories/film_repository_impl.dart';
import 'package:bioskopin/features/film/domain/repositories/film_repository.dart';
import 'package:bioskopin/features/film/domain/usecases/booking_film.dart';
import 'package:bioskopin/features/film/domain/usecases/get_detail_film.dart';
import 'package:bioskopin/features/film/presentation/bloc/film_bloc.dart';
import 'package:bioskopin/features/film/presentation/cubit/booking_film_cubit.dart';
import 'package:bioskopin/features/home/data/datasources/remote/home_api_service.dart';
import 'package:bioskopin/features/home/data/repositories/home_repository_impl.dart';
import 'package:bioskopin/features/home/domain/repositories/home_repository.dart';
import 'package:bioskopin/features/home/domain/usecases/get_home.dart';
import 'package:bioskopin/features/home/presentation/bloc/home_bloc.dart';
import 'package:bioskopin/features/profile/data/datasources/remote/profile_api_service.dart';
import 'package:bioskopin/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bioskopin/features/profile/domain/repositories/profile_repository.dart';
import 'package:bioskopin/features/profile/domain/usecases/edit_profile.dart';
import 'package:bioskopin/features/profile/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bioskopin/features/profile/presentation/cubit/logout/logout_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Shared Preferences
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Services & Repositories
  sl.registerSingleton<AuthLocalService>(AuthLocalService(sl()));
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  sl.registerSingleton<HomeApiService>(HomeApiService(sl()));
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl(), sl()));

  sl.registerSingleton<FilmApiService>(FilmApiService(sl()));
  sl.registerSingleton<FilmRepository>(FilmRepositoryImpl(sl(), sl()));

  sl.registerSingleton<BookingApiService>(BookingApiService(sl()));
  sl.registerSingleton<BookingRepository>(BookingRepositoryImpl(sl(), sl()));

  sl.registerSingleton<ProfileApiService>(ProfileApiService(sl()));
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl(), sl()));

  // Usecases
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(sl()));
  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl()));
  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl()));
  sl.registerSingleton<RemoveUserUseCase>(RemoveUserUseCase(sl()));
  sl.registerSingleton<SaveUserUseCase>(SaveUserUseCase(sl()));

  sl.registerSingleton<GetHomeUseCase>(GetHomeUseCase(sl()));

  sl.registerSingleton<GetDetailFilmUseCase>(GetDetailFilmUseCase(sl()));
  sl.registerSingleton<BookingFilmUseCase>(BookingFilmUseCase(sl()));

  sl.registerSingleton<GetBookingUseCase>(GetBookingUseCase(sl()));

  sl.registerSingleton<EditProfileUseCase>(EditProfileUseCase(sl()));

  // Blocs & Cubit
  sl.registerSingleton<UserCubit>(UserCubit(sl(), sl()));

  sl.registerSingleton<SplashCubit>(SplashCubit(sl()));

  sl.registerFactory<SigninCubit>(() => SigninCubit(sl(), sl()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));

  sl.registerFactory<FilmBloc>(() => FilmBloc(sl()));

  sl.registerFactory<BookingFilmCubit>(() => BookingFilmCubit(sl()));

  sl.registerFactory<BookingBloc>(() => BookingBloc(sl()));

  sl.registerFactory<LogoutCubit>(() => LogoutCubit(sl()));
  sl.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(sl(), sl(), sl()),
  );
}
