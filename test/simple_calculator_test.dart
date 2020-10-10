import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calculator/src/blocs/calculator/calculator_bloc.dart';

class MockCounterBloc extends MockBloc<int> implements CalculatorBloc {}

void main() {
  group('CalculatorBloc', () {
    CalculatorBloc calculatorBloc;

    setUp(() {
      calculatorBloc = CalculatorBloc();
    });

    test('initial result is 0', () {
      expect(calculatorBloc.state.result, '0');
    });

    blocTest(
      'emits 1 when CalculatorExpressionChanged added',
      build: () => calculatorBloc,
      act: (CalculatorBloc bloc) => bloc.add(CalculatorExpressionChanged('1')),
      expect: [
        CalculatorState.expressionChanged('1'),
      ],
    );

    blocTest(
      'should has result 55 when add CalculatorResultChanged with expression 11×5',
      build: () => calculatorBloc,
      act: (CalculatorBloc bloc) => bloc.add(CalculatorResultChanged('11×5')),
      expect: [
        CalculatorState.resultChanged('55'),
      ],
    );

    blocTest(
      'should has result Error when expression 11×5×××',
      build: () => calculatorBloc,
      act: (CalculatorBloc bloc) =>
          bloc.add(CalculatorResultChanged('11×5×××')),
      expect: [
        CalculatorState.resultChanged('Error'),
      ],
    );
  });
}
