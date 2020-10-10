import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expressions/expressions.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState.initial());

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is CalculatorExpressionChanged) {
      yield* _mapCalculatorTextChangedToState(event);
    } else if (event is CalculatorResultChanged) {
      yield* _mapCalculatorResultChangedToState(event);
    }
  }

  Stream<CalculatorState> _mapCalculatorTextChangedToState(
    CalculatorExpressionChanged event,
  ) async* {
    var calcText = state.expression;

    if (event.expression == '⌫') {
      if (calcText.length > 0) {
        calcText = calcText.substring(0, calcText.length - 1);
      }
    } else if (event.expression == 'C') {
      calcText = '';
    } else if (event.expression == '=') {
      calcText = state.expression;
    } else {
      calcText += event.expression;
    }
    yield CalculatorState.expressionChanged(calcText);
  }

  Stream<CalculatorState> _mapCalculatorResultChangedToState(
    CalculatorResultChanged event,
  ) async* {
    try {
      var filterCalcText = event.expression;
      filterCalcText = filterCalcText.replaceAll('×', '*');
      filterCalcText = filterCalcText.replaceAll('÷', '/');
      Expression expression = Expression.parse(filterCalcText);

      Map<String, dynamic> evContext = {};

      final evaluator = ExpressionEvaluator();
      var result = evaluator.eval(expression, evContext);

      yield CalculatorState.resultChanged(result.toString());
    } catch (e) {
      yield CalculatorState.resultChanged('Error');
    }
  }
}
