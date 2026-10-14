// Flutter imports:
import 'package:bioskopin/core/cubit/user_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bioskopin/core/injection_container.dart';
import 'package:bioskopin/core/utils/form_validator.dart';
import 'package:bioskopin/core/widgets/button.dart';
import 'package:bioskopin/core/widgets/input.dart';
import 'package:bioskopin/core/widgets/input_password.dart';
import 'package:bioskopin/core/widgets/overlay_loader.dart';
import 'package:bioskopin/features/authentication/presentation/cubit/signin/signin_cubit.dart';

class SigninPage extends HookWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return BlocProvider(
      create: (context) => sl<SigninCubit>(),
      child: BlocListener<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            context.read<UserCubit>().onLoadUser();

            context.go('/home');
          } else if (state is SigninFailure) {
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
          body: BlocBuilder<SigninCubit, SigninState>(
            builder: (context, state) {
              return SafeArea(
                child: OverlayLoader(
                  isLoading: state is SigninLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 100.0,
                            ),
                          ),
                          const Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Silakan masuk untuk melanjutkan',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                          const SizedBox(height: 20.0),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                CustomInput(
                                  label: 'Email',
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  validator: FormValidator.validateEmail,
                                ),
                                const SizedBox(height: 10.0),
                                CustomInputPassword(
                                  label: 'Kata Sandi',
                                  controller: passwordController,
                                  validator: FormValidator.validatePassword,
                                ),
                                const SizedBox(height: 30.0),
                                CustomButton(
                                  label: 'Masuk',
                                  borderRadius: 10.0,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      context.read<SigninCubit>().onSignin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                    }
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                RichText(
                                  text: TextSpan(
                                    text: 'Belum punya akun? ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Daftar',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.push('/auth/signup');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
