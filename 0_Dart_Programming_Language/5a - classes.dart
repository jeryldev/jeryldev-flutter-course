import '5b - private_property_and_class.dart';
import '5c - getters_setters_static.dart';

void main() {
  // Creating a new instance of a class object
  final father = Person('Jeryl');
  print(father); // Instance of 'Person'
  father.printPersonInfo(); // My name is Jeryl, I'm 1 year(s) old.

  // Update the property of the Class Object
  father.age = 29;
  father.cityName = 'Taguig, City';
  // father._name = 'Jeryl Donato Estopace';
  father.printPersonInfo(); // My name is Jeryl, I'm 29 year(s) old.
  father.printAddressInfo(); // I live in Taguig, City.

  // Getters and Setters
  final user1 = User('Jeryl');
  print(user1.age); // null
  user1.age = -10;
  print(user1.age); // 1
  user1.age = 29;
  print(user1.age); // 29
  final user2 = User('Ara');
  user2.age = 30;
  final user3 = User('Athena');
  user3.age = 4;
  final user4 = User('Mavis');
  user4.age = 2;

  // static
  // We can access the static properties and methods through the Class name.
  print(
      'Current number of Users: ${User.getNumberOfUsers()}'); // Current number of Users: 4
}

// We use extends keyword to extends all the Public properties and Methods of the Location Class
// Note that I can extend LocationTest but not the private class, _SecretLocation
class Person extends LocationTest {
  String name;
  int age;

  // We can create a Local Constructor that accepts
  // two parameters and will return an Object for us
  // This will make the Class instantiate for us.
  // We can use the Positional named Parameters to assign the Default value of the age
  // We can also use the Optional named Parameters as well.
  // However,we cannpt combine both
  // Person(String name, [int age = 1]) {
  //   this.name = name;
  //   this.age = age;
  // }
  // Here's another way of making the Constructor
  // Person(String name, [int age = 1])
  //     : this.name = name,
  //       this.age = age;

  // This is a Short way of creating a local Constructor in Dart
  // with a Positional named Parameter to assign the Default value of the age
  Person(this.name, [this.age = 1]);
  // Person({this.name, this.age});

  // Person njeryl = Person( 29, 'jeryl');
  LocationTest test = LocationTest();

  // A method to Print a Person's information
  void printPersonInfo() => print('My name is $name, I\'m $age year(s) old.');
  void printAddressInfo() => print('I live in $cityName.');
  // We are still able to access the properties of the Private Class because
  // we extended the Private Class (_SecretLocation) to the LocationTest class
  void printCoordinatesInfo() =>
      print('Coordinates = Lat: $latitude, Long: $longitude');
}
