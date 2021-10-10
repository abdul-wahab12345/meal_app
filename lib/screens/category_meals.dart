import 'package:flutter/material.dart';
import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMeals extends StatefulWidget {
  static final route = '/category-meals';
  final List<Meal> _avalibleMeals;
  CategoryMeals(this._avalibleMeals);

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String title = '';
  String id = '';
  List<Meal> categoryMeal = [];
  bool _loadedData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _removeMeal(String mealID) {
    setState(() {
      categoryMeal.removeWhere((element) => element.id == mealID);
    });
  }

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      _loadedData = true;

      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      title = arguments['title'] as String;
      id = arguments['id'] as String;

      categoryMeal = widget._avalibleMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeal[index].id,
            title: categoryMeal[index].title,
            imageUrl: categoryMeal[index].imageUrl,
            duration: categoryMeal[index].duration,
            complexity: categoryMeal[index].complexity,
            affordability: categoryMeal[index].affordability,
          );
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}
