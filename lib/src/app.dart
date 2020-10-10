import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_calculator/src/blocs/calculator/calculator_bloc.dart';
import 'package:simple_calculator/src/simple_calculator.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<CalculatorBloc>(
        create: (context) => CalculatorBloc(),
        child: SimpleCalculator(),
      ),
    );
  }
}
