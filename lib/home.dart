import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/salkhana/data/model/member.dart';
import 'features/salkhana/presentation/cubit/salkhana_cubit.dart';
import 'features/salkhana/presentation/cubit/salkhana_states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
      ),
      body: BlocConsumer<SalkhanaCubit, SalkhanaStates>(
        buildWhen: (previous, current) => (current is SalkhanaSucsses ||
            current is SalkhanaLoading ||
            current is SalkhanaFailureNetwork),
        listener: (context, state) {
          if (state is SalkhanaSucssesFirestore) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Sucssesful")));
          }
        },
        builder: (context, state) {
          if (state is SalkhanaSucsses) {
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
    );
  }
}
