import 'package:flutter/material.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
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
                        child: TextField(
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
                          onChanged: (value) {
                            if (value.isEmpty) {
                            } else {}
                          },
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
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            height: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
                Text("Mostafa Ahmed",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
