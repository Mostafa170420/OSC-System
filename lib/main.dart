import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/screens/dashboard_screen.dart';

import '/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import '/firebase_options.dart';
import 'core/theme.dart';
import 'features/salkhana/data/repositories/salkhana_repository_imp.dart';
import 'features/salkhana/presentation/cubit/theme_cubit.dart';
import 'features/salkhana/presentation/cubit/theme_states.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SalkhanaCubit(salkhanaRepository: SalkhanaRepositoryImp())
                ..getMembers(),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child:BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
             theme: state is LightThemeState
                ? AppThemes.lightTheme
                : AppThemes.darkTheme,  // 🌟 Uses the selected theme
            home: DashboardScreen(),
          );
        },
      ),
    );
  }
}


