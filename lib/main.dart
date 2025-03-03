import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/data/repositories/salkhana_repository_imp.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_states.dart';
import 'package:osc_system/features/workshop/presentation/cubit/workshop_cubt.dart';
import 'package:osc_system/features/workshop/presentation/cubit/workshop_states.dart';
import 'package:osc_system/firebase_options.dart';
import 'package:osc_system/home.dart';

void main() async {
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
    return BlocProvider(
      create: (context) =>
          SalkhanaCubit(salkhanaRepository: SalkhanaRepositoryImp())
            ..getMembers(),
      child: MaterialApp(title: 'Flutter Demo', home: Home()),
    );
  }
}
