// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bioskopin/core/cubit/user_cubit.dart';
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/core/widgets/button.dart';
import 'package:bioskopin/features/profile/presentation/cubit/logout/logout_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.go('/auth');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[700],
                content: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Anda berhasil logout!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10.0),
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[700],
                content: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10.0),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profil'),
          ),
          body: BlocBuilder<LogoutCubit, LogoutState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            state.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            state.email,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          shape: const Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(224, 224, 224, 1),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Edit Profil'),
                      shape: const Border.symmetric(
                        horizontal: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(224, 224, 224, 1),
                        ),
                      ),
                      onTap: () {
                        context.push('/edit-profile');
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        label: 'Keluar',
                        backgroundColor: Colors.red[700],
                        borderRadius: 10.0,
                        onPressed: () {
                          context.read<LogoutCubit>().onLogout();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
