import 'package:flutter/material.dart';
import 'package:osc_system/core/constant/contant.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          spacing: 10,
          children: [
            for (int i = 0; i < commities.length; i++)
              Expanded(
                child: MaterialButton(
                  color: Theme.of(context).canvasColor,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(flex: 2, child: Image.asset(commities[i][0])),
                        Expanded(
                            child: Text(
                          commities[i][1],
                          style: Theme.of(context).textTheme.labelMedium,
                        ))
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              )
          ],
        ),
      ),
    );
  }
}
//  padding: EdgeInsets.all(20),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).canvasColor,
//                 borderRadius: BorderRadius.circular(15)
//               ),
//               child:
