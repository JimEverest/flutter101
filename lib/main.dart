// Define a class that extends InheritedWidget and holds some data
import 'dart:math';
import 'package:flutter/material.dart';

class RandomNumber extends InheritedWidget {
  final int value;

  RandomNumber({this.value = 0, required Widget child}) : super(child: child);

  static RandomNumber of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RandomNumber>() ??
        RandomNumber(value: 0, child: Container());
  }

  @override
  bool updateShouldNotify(RandomNumber oldWidget) {
    // var _modify = (value != oldWidget.value);
    // print(value != oldWidget.value);
    return value != oldWidget.value || this != oldWidget;
  }
}

// Use the RandomNumber widget somewhere in your app
class MyApp extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Random random = Random();
  int randomNumber = 0;

  @override
  void initState() {
    super.initState();
    generateRandomNumber(); // Call generateRandomNumber on app load
  }

  void generateRandomNumber() {
    print('debug: Generating new random number。。。。。。。。。。。。。。。。');
    setState(() {
      randomNumber = random.nextInt(100);
      print('debug: Random number is now: $randomNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RandomNumber(
          value: randomNumber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('The current random number is:'),
                Text(RandomNumber.of(context)?.value?.toString() ?? '0'),
                // Builder(builder: (context) {
                //   return Text(RandomNumber.of(context).value.toString() ?? '0');
                // }),
                Text('Another widget using the same random number:'),
                RandomNumberChild(),
                ElevatedButton(
                  onPressed: generateRandomNumber,
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

class RandomNumberChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(RandomNumber.of(context)?.value?.toString() ?? '0');
  }
}

void main() {
  runApp(MyApp());
}
