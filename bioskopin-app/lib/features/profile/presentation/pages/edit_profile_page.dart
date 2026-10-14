// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bioskopin/core/cubit/user_cubit.dart';
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/core/utils/form_validator.dart';
import 'package:bioskopin/core/widgets/button.dart';
import 'package:bioskopin/core/widgets/input.dart';
import 'package:bioskopin/core/widgets/overlay_loader.dart';
import 'package:bioskopin/features/profile/presentation/cubit/edit_profile/edit_profile_cubit.dart';

class EditProfilePage extends HookWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final nameController = useTextEditingController();
    final emailController = useTextEditingController();

    useEffect(
      () {
        nameController.text = context.read<UserCubit>().state.name;
        emailController.text = context.read<UserCubit>().state.email;

        return null;
      },
      [],
    );

    return BlocProvider(
      create: (context) => sl<EditProfileCubit>(),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            context.pop();

            context.read<UserCubit>().onLoadUser();

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
                        'Profil berhasil diubah!',
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
          } else if (state is EditProfileFailure) {
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
            title: const Text('Edit Profil'),
          ),
          body: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return SafeArea(
                child: OverlayLoader(
                  isLoading: state is EditProfileLoading,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomInput(
                              label: 'Nama',
                              controller: nameController,
                              validator: FormValidator.validateName,
                            ),
                            const SizedBox(height: 10.0),
                            CustomInput(
                              label: 'Email',
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              validator: FormValidator.validateEmail,
                            ),
                            const SizedBox(height: 30.0),
                            CustomButton(
                              label: 'Simpan Perubahan',
                              borderRadius: 10.0,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  context
                                      .read<EditProfileCubit>()
                                      .onEditProfile(
                                        name: nameController.text,
                                        email: emailController.text,
                                      );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
