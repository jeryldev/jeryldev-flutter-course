main() {
  // the singleton pattern is a software design pattern that restricts
  // the instantiation of a class to one "single" instance.
  // This is useful when exactly one object is needed
  // to coordinate actions across the system.
  // A good example of this is when interacting with a Cloud Firestore DB.
  // We can create a Singleton class to ensure that we are only
  // interacting with a single instance of the Cloud Firestore Database
  var s1 = SingletonTest();
  var s2 = SingletonTest();

  // The following test result does not mean that we are instantiating twice.
  // What this means is that we are only referencing to the same Singleton object twice;
  print(identical(s1, s2)); // true
  print(s1 == s2); // true

  var ss1 = SingletonSimple.instance;
  var ss2 = SingletonSimple.instance;
  print(identical(ss1, ss2)); // true
  print(ss1 == ss2); // true
}

// Here, we are creating a Singleton pattern using the Factory Constructor
// To access this in another library, we can use "SingletonTest()"
class SingletonTest {
  static final SingletonTest _singleton = SingletonTest._internal();

  // We can use the factory keyword when implementing a constructor
  // that doesn’t always create a new instance of its class.
  factory SingletonTest() {
    return _singleton;
  }

  SingletonTest._internal();
}

// Here's another form of a Singleton pattern in Dart
// To access this in another library, we can use "SingletonSimple.instance"
class SingletonSimple {
  SingletonSimple._();

  static final instance = SingletonSimple._();
}
