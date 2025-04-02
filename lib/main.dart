import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/presentation/screens/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'core/theme/theme.dart';
import 'features/salkhana/data/repositories/salkhana_repository_imp.dart';
import 'features/salkhana/presentation/cubit/sidebar_cubit.dart';
import 'features/salkhana/presentation/cubit/theme_cubit.dart';
import 'features/salkhana/presentation/cubit/theme_states.dart';
import 'features/salkhana/presentation/screens/dashboard_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://juwsfchmxxcpudzwfdiv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1d3NmY2hteHhjcHVkendmZGl2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEwMzg3MDIsImV4cCI6MjA1NjYxNDcwMn0.arEI8z_RXipUw_BN66aGEBuATVnKmiC5wyLH9wHYT_I',
  );

//   // Initialize Hive
//   await Hive.initFlutter();

//   // Register the adapter
//   Hive.registerAdapter(SalkhanaMemberModelAdapter());

//   // Open a Hive box
//   await Hive.openBox<SalkhanaMemberModel>('salkhana_members');
//   var box = Hive.box<SalkhanaMemberModel>('salkhana_members');
//  print( box.getAt(0)); // Example of how to use the box

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
            create: (context) =>
                SalkhanaCubit(salkhanaRepository: SalkhanaRepositoryImp())
                  ..getMembers()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
       child:BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
             theme: state is LightThemeState
                ? AppThemes.lightTheme
                : AppThemes.darkTheme,  // 🌟 Uses the selected theme
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}

