part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  const CalculatorState._({
    this.result = '0',
    this.expression = '',
  });

  const CalculatorState.initial() : this._();

  const CalculatorState.resultChanged(String result) : this._(result: result);

  const CalculatorState.expressionChanged(String expression)
      : this._(expression: expression);

  final String result;
  final String expression;

  @override
  List<Object> get props => [result, expression];
}
