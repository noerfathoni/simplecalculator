import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:simple_calculator/src/blocs/calculator/calculator_bloc.dart';

class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Simple Calculator'),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Boxicons.bx_info_circle),
              onPressed: () {
                _showAboutDialog(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.expression.isEmpty ? '0' : state.expression,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          state.result,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          CalcButton(
                            label: 'C',
                            height: 1,
                            color: Colors.deepOrange,
                          ),
                          CalcButton(
                            label: '⌫',
                            height: 1,
                            textColor: Colors.deepOrange,
                          ),
                          CalcButton(
                            label: '+',
                            height: 1,
                            textColor: Colors.deepOrange,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(label: '7', height: 1),
                          CalcButton(label: '8', height: 1),
                          CalcButton(label: '9', height: 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(label: '4', height: 1),
                          CalcButton(label: '5', height: 1),
                          CalcButton(label: '6', height: 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(label: '1', height: 1),
                          CalcButton(label: '2', height: 1),
                          CalcButton(label: '3', height: 1),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(label: '.', height: 1),
                          CalcButton(label: '0', height: 1),
                          CalcButton(label: '00', height: 1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          CalcButton(
                            label: '-',
                            height: 1,
                            textColor: Colors.deepOrange,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(
                            label: '×',
                            height: 1,
                            textColor: Colors.deepOrange,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(
                            label: '÷',
                            height: 1,
                            textColor: Colors.deepOrange,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalcButton(
                            label: '=',
                            height: 2,
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AboutDialog(
        applicationVersion: '1.0.0',
        children: [
          Text('Simple Calculator build with Flutter Bloc'),
          SizedBox(height: 16),
          Text(
            'Created by:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Text('noerfathoni <noer.fathoni1@gmail.com>'),
        ],
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  final String label;
  final int height;
  final Color color;
  final Color textColor;

  CalcButton(
      {@required this.label, @required this.height, this.color, this.textColor})
      : assert(label != null),
        assert(height != null);

  @override
  Widget build(BuildContext context) {
    var mainHeight = (MediaQuery.of(context).size.width * 1 / 4) * height;

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (label == '=') {
              context
                  .bloc<CalculatorBloc>()
                  .add(CalculatorResultChanged(state.expression));
            } else {
              context
                  .bloc<CalculatorBloc>()
                  .add(CalculatorExpressionChanged(label));
            }
          },
          child: Container(
            height: height > 1 ? mainHeight + (height * 2) : mainHeight,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: color ?? Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Container(
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
