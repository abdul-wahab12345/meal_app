import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../modals/meal.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favouritedMeals;
  Favorites(this.favouritedMeals);

  @override
  Widget build(BuildContext context) {
    if (favouritedMeals.isEmpty) {
      return Center(
        child: Text('Empty Favorites! - Try adding some'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: favouritedMeals[index].id,
              title: favouritedMeals[index].title,
              imageUrl: favouritedMeals[index].imageUrl,
              duration: favouritedMeals[index].duration,
              complexity: favouritedMeals[index].complexity,
              affordability: favouritedMeals[index].affordability);
        },
        itemCount: favouritedMeals.length,
      );
    }
  }
}
