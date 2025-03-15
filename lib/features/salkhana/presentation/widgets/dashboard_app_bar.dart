import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_cubit.dart';

class DashboardAppBar extends StatelessWidget {
  DashboardAppBar({super.key});
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Dashboard",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        child: TextFormField(
                          controller: text,
                          onChanged: (value) =>
                              BlocProvider.of<SalkhanaCubit>(context)
                                  .searshMember(value),
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.grey),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                          // onChanged: (value) {
                          //   if (value.isEmpty) {
                          //   } else {}
                          // },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              width: size.width / 5,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: Text("Mostafa Ahmed",
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
