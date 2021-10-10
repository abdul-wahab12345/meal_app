import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import '../modals/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetails.route,
      arguments: id,
    );
  }

  String get complexityText {
    if (complexity == Complexity.Simple) {
      return "Simple";
    } else if (complexity == Complexity.Challenging) {
      return "Challenging";
    } else {
      return "Hard";
    }
  }

  String get affordibilityText {
    if (affordability == Affordability.Affordable) {
      return "Affordable";
    } else if (affordability == Affordability.Pricey) {
      return "Pricey";
    } else {
      return "Luxurious";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  color: Colors.black54,
                  width: 300,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 6,
                    ),
                    Text("$duration min"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.work),
                    SizedBox(
                      width: 6,
                    ),
                    Text(complexityText),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(
                      width: 6,
                    ),
                    Text(affordibilityText),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
