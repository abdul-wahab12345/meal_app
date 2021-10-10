import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const String route = '/filters';
  Function filterData;
  Map<String, bool> currentFilters;
  Filters({Key? key, required this.filterData, required this.currentFilters})
      : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var glutenFree = false;
  var vegetarian = false;
  var vegen = false;
  var lactoseFree = false;
  @override
  initState() {
    glutenFree = widget.currentFilters['gluten'] as bool;
    vegetarian = widget.currentFilters['vegetarian'] as bool;
    vegen = widget.currentFilters['vegen'] as bool;
    lactoseFree = widget.currentFilters['lactose'] as bool;
  }

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegen': false,
    'vegetarian': false,
  };

  @override
  Widget build(BuildContext context) {
    Widget _buildSwitchTile(
        String title, String subtitle, bool currentval, var updateValue) {
      return SwitchListTile(
        title: Text(title),
        value: currentval,
        subtitle: Text(subtitle),
        onChanged: updateValue,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        actions: [
          IconButton(
              onPressed: () {
                widget.filterData({
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegen': vegen,
                  'vegetarian': vegetarian,
                });
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  "Gluten Free",
                  "Only include gluten free meals",
                  glutenFree,
                  (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  },
                ), //end switch,
                _buildSwitchTile(
                  "Lactose Free",
                  "Only include lactose free meals",
                  lactoseFree,
                  (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  },
                ), //end switch,
                _buildSwitchTile(
                  "Vegetarian",
                  "Only include Vegetarian meals",
                  vegetarian,
                  (newValue) {
                    setState(() {
                      vegetarian = newValue;
                    });
                  },
                ), //end switch,
                _buildSwitchTile(
                  "Vegen",
                  "Only include Vegen meals",
                  vegen,
                  (newValue) {
                    setState(() {
                      vegen = newValue;
                    });
                  },
                ), //end switch,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
