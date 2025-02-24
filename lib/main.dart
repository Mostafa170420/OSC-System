
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/workshop/presentation/cubit/workshop_cubt.dart';
import 'package:osc_system/features/workshop/presentation/cubit/workshop_states.dart';
import 'package:osc_system/firebase_options.dart';

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
    return MaterialApp(
        title: 'Flutter Demo',
        home: BlocProvider(
          create: (context) => WorkshopCubt()..getMembers(),
          child: Scaffold(
            appBar: AppBar(
              title: Text("App"),
            ),
            body: BlocBuilder<WorkshopCubt, WorkshopStates>(
              builder: (context, state) {
                if (state is WorkshopSuccsses) {
                  return ListView.builder(
                    itemCount: state.members.length,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(left: 50),
                      height: 60,
                      color: Colors.blue,
                      child: Row(
                        spacing: 50,
                        children: [
                          Text(state.members[index].id),
                          Text(state.members[index].name)
                        ],
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ));
  }
}
