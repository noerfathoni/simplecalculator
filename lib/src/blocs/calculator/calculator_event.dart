part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculatorResultChanged extends CalculatorEvent {
  const CalculatorResultChanged(this.expression);

  final String expression;

  @override
  List<Object> get props => [expression];
}

class CalculatorExpressionChanged extends CalculatorEvent {
  const CalculatorExpressionChanged(this.expression);

  final String expression;

  @override
  List<Object> get props => [expression];
}
