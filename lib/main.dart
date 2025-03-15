import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import '/firebase_options.dart';
import 'core/constant/bloc_observer.dart';
import 'core/theme/theme.dart';
import 'features/salkhana/data/repositories/salkhana_repository_imp.dart';
import 'features/salkhana/presentation/cubit/theme_cubit.dart';
import 'features/salkhana/presentation/screens/dashboard_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://juwsfchmxxcpudzwfdiv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1d3NmY2hteHhjcHVkendmZGl2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEwMzg3MDIsImV4cCI6MjA1NjYxNDcwMn0.arEI8z_RXipUw_BN66aGEBuATVnKmiC5wyLH9wHYT_I',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
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
                  ..getMembers()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme, // 🌟 Uses the selected theme
        home: DashboardScreen(),
      ),
    );
  }
}
