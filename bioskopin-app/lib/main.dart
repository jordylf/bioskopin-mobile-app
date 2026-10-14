// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

// Project imports:
import 'package:bioskopin/config/router/app_router.dart';
import 'package:bioskopin/config/theme/app_theme.dart';
import 'package:bioskopin/core/cubit/user_cubit.dart';
import 'package:bioskopin/core/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await initializeDependencies();

  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserCubit>(),
      child: MaterialApp.router(
        title: 'Bioskopin',
        theme: theme(),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
