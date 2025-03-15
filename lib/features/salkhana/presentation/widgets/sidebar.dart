import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(25),
              child: Image.asset("assets/images/OSC_logo.png"),
            ),
            DrawerListTile(
                icon: Icons.dashboard, title: "Dashboard", screen: SizedBox()),
            DrawerListTile(
                icon: Icons.people, title: "Members", screen: SizedBox()),
            DrawerListTile(
                icon: Icons.settings, title: "Settings", screen: SizedBox())
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.screen});
  final IconData icon;
  final String title;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
      minTileHeight: 60,
      contentPadding: EdgeInsets.only(left: 20),
      onTap: () {},
      horizontalTitleGap: 30,
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
