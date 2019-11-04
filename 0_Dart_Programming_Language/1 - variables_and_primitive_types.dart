void main() {
  // Dart

  // Common Primitives
  String name = 'Jeryl';
  int age = 29;
  // bool isValid = true;
  // double pi = 3.1416;

  // String interpolation
  print(
      'Hello everyone! My name is $name. I\'m $age. 10 more years from now, I will turn ${age + 10}.');

  // we can assign any value in a dynamic variable
  dynamic value = 'test';
  print('value Variable Type: ${value.runtimeType}');
  value = 15;
  print('value Variable Type: ${value.runtimeType}');
  print('value: $value.');

  // we can use var to declare a variable
  // initially, the type of the variable will be "Null".
  // However, later on, the type of the value assigned will
  // become the type of the variable due to Type Inference.
  var surname;
  print('surname: $surname'); // Null
  print('surname Variable Type: ${surname.runtimeType}'); // Null
  surname = 'Estopace';
  print('surname Variable Type: ${surname.runtimeType}'); // String
  surname = 123;
  print('surname Variable Type: ${surname.runtimeType}'); // int

  // All values in Dart are "mutable" which means that values can change at run time.
  // We can re-assign values in variables during its execution at run-time.
  String pet = "cat";
  pet = "dog";
  print('pet: $pet');
  // We can use "final" or "const" keywords to if we want
  // to initialize the variables values only once.
  final String favoriteColor = "blue";
  // favoriteColor = "green";
  // 'favoriteColor', a final variable, can only be set once. Try making 'favoriteColor' non-final.dart(assignment_to_final_local)
  print('Favorite Color: $favoriteColor');

  // const can be used if we want that the values to be known at compile time.
  const String favoriteFood = "adobo";
  // favoriteFood = "tinola";
  // Constant variables can't be assigned a value. Try removing the assignment, or remove the modifier 'const' from the variable.dart(assignment_to_const)
  print('Favorite Food: $favoriteFood');
}
