// Define a class that extends InheritedWidget and holds some data
import 'dart:math';
import 'package:flutter/material.dart';

class RandomNumber extends InheritedWidget {
  // The data can be any type, for example an int
  final int value;

  // The constructor takes the data and a child widget as parameters
  RandomNumber({required this.value, required Widget child})
      : super(child: child);

  // A method that returns an instance of RandomNumber from the given context
  // This is how you can access the data from anywhere in the widget tree
  static RandomNumber of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RandomNumber>()!;
  }

  // A method that tells Flutter whether to rebuild the widgets that depend on this widget
  // If the data changes, return true; otherwise return false
  @override
  bool updateShouldNotify(RandomNumber oldWidget) {
    return value != oldWidget.value;
  }
}

// Use the RandomNumber widget somewhere in your app
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create a random number generator and an initial value for the random number
  final Random random = Random();
  int randomNumber = -1;

  // A method that updates the state with a new random number between 0 and 100
  void generateRandomNumber() {
    setState(() {
      randomNumber = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RandomNumber(
          value: randomNumber, // Pass some data to RandomNumber widget
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('The current random number is:'),
                Text(RandomNumber.of(context)
                    .value
                    .toString()), // Access the data using RandomNumber.of(context)
                ElevatedButton(
                  onPressed:
                      generateRandomNumber, // Call the method when clicking on button
                  child: Text('Generate new random number'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
