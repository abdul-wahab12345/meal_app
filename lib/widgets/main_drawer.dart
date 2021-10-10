import 'package:flutter/material.dart';
import '../screens/filters.dart';
import '../screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTile(IconData icon, String title, Function selectHandler) {
      return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "RobotoCondensed",
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        onTap: () => selectHandler(),
      );
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildTile(
            Icons.restaurant,
            "Meals",
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildTile(
            Icons.settings,
            "Filters",
            () {
              Navigator.of(context).pushReplacementNamed(Filters.route);
            },
          ),
        ],
      ),
    );
  }
}
