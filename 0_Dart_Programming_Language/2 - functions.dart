import 'dart:math';

void main() {
  print(sum(10, 10)); // 20.0
  difference(20, 5); // 15.0
  product(5, 10); // 50.0
  product(5, 10, c: 3); // 150.0
  exponentiation(3); // 3.0
  exponentiation(3, 3); // 27.0
  print(quotient(dividend: 25, divisor: 5)); // 5.0

  // Function dividedBy2 is like quotient(dividend: x, divisor: 2);
  final dividedBy2 = setDefaultDivisor(2);
  print(dividedBy2(100.0)); // 50
}

// double is the return type of function sum
// sum is the name of the function
// (double a, double b) are the parameters required by the function
double sum(double a, double b) {
  return a + b;
}

// void does not "return" any type. It just performs an operation.
void difference(double a, double b) {
  print(a - b);
}

// Named optional parameters.
// Using Named parameters are very useful especially when
// making large and complex applications
void product(double a, double b, {double c}) {
  // Ternary Operator can be used as a shorthand for simple if-else statements
  c == null ? print(a * b) : print(a * b * c);
}

// Positional optional paramenters.
// Using Positional parameters are also very useful
// when making large and complex applications
// pow method comes from the Math Library from Dart
void exponentiation(double a, [double e = 1]) {
  print(pow(a, e));
}

// => We can use arrow functions to simplify our functions in Dart and Flutter
// double is the return type of function quotient
double quotient({double dividend, double divisor}) => dividend / divisor;

// We could also pass Functions inside another Function
// this is especially useful if we are expecting values first from another function
// before we acually execute the primary function
// This kind of function is rarely used but is good to know.
Function setDefaultDivisor(double value) {
  return (x) => quotient(dividend: x, divisor: value);
}
