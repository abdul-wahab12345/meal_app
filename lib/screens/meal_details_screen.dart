import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/modals/meal.dart';

class MealDetails extends StatelessWidget {
  static String route = '/meal-details';
  Function toggleFavourite;
  Function isFavourite;
  MealDetails(this.toggleFavourite, this.isFavourite);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

    final Meal meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meal.imageUrl),
            ),
            _buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: _buildSectionTitle(context, meal.ingredients[index]),
                  );
                },
              ),
            ),
            _buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          "# ${(index + 1)}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourite(mealId),
        child: Icon(
          isFavourite(mealId) ? Icons.star : Icons.star_border,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
