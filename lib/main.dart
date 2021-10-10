import 'package:flutter/material.dart';
import './dummy_data.dart';
import './modals/meal.dart';
import '../screens/filters.dart';
import './screens/tab_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegen': false,
    'vegetarian': false,
  };

  List<Meal> _avalibleMeals = DUMMY_MEALS;
  List<Meal> favouritedMeals = [];

  void toggleFavourite(String mealId) {
    final int index = favouritedMeals.indexWhere((meal) => meal.id == mealId);

    setState(() {
      if (index >= 0) {
        favouritedMeals.removeAt(index);
      } else {
        favouritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool isFavourite(String id) {
    return favouritedMeals.any((meal) => meal.id == id);
  }

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      _avalibleMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegen'] as bool && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
      print(filterData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              subtitle2: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 18,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favouritedMeals),
        CategoryMeals.route: (ctx) => CategoryMeals(_avalibleMeals),
        MealDetails.route: (ctx) => MealDetails(toggleFavourite, isFavourite),
        Filters.route: (ctx) => Filters(
              filterData: setFilters,
              currentFilters: filters,
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
