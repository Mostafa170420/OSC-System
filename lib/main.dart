import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:osc_system/core/api/dio_consumer.dart';
import 'package:osc_system/features/emails/data/repositories/email_repository_imp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'core/theme/theme.dart';
import 'features/salkhana/data/model/member.dart';
import 'features/salkhana/data/repositories/salkhana_repository_imp.dart';
import 'features/salkhana/presentation/cubit/sidebar_cubit.dart';
import 'features/salkhana/presentation/cubit/theme_cubit.dart';
import 'features/salkhana/presentation/cubit/theme_states.dart';
import 'features/salkhana/presentation/screens/auth/login_screen.dart';
import 'features/salkhana/presentation/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://juwsfchmxxcpudzwfdiv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1d3NmY2hteHhjcHVkendmZGl2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEwMzg3MDIsImV4cCI6MjA1NjYxNDcwMn0.arEI8z_RXipUw_BN66aGEBuATVnKmiC5wyLH9wHYT_I',
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(SalkhanaMemberModelAdapter());

  // Open a Hive box
  await Hive.openBox<SalkhanaMemberModel>('salkhana_member');
  await Hive.openBox('authAdmin');
  // final box = Hive.box<SalkhanaMemberModel>('salkhana_members');

  // Listen to Hive box changes

  // Print existing data in the box
  // print("Initial data in box:");
  // for (var key in box.keys) {
  //   print(box.get(key));
  // }

  print("===========================================");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SidebarCubit(),
        ),
        BlocProvider(
            create: (context) => SalkhanaCubit(
                emailRepository: EmailRepositoryImp(api: DioConsumer()))
              ..getMembers()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state is LightThemeState
                ? AppThemes.lightTheme
                : AppThemes.darkTheme, // 🌟 Uses the selected theme
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
