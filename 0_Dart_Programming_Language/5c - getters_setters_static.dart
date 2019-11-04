class User {
  String name;
  int _age;
  // static means that this property is shared by every object instance of User
  static int numberOfUser = 0;

  // Constructor with name as the only parameter
  User(String name) {
    this.name = name;
    numberOfUser++;
  }

  static String getNumberOfUsers() => numberOfUser.toString();

  // To protect the internal data from being accessed directly,
  // we could use getters and setters.
  // get allows our function to get the value of the private property
  int get age => _age;

  // set allows our function to set the value of the private property
  set age(int value) {
    // If value is less than or equal to zero or null,
    // the age should be equal to 1, otherwise,
    // let the user input control the age
    value <= 0 ? _age = 1 : _age = value;

    // It is similar to this expression
    // if (value <= 0) {
    //   _age = 1;
    // } else {
    //   _age = value;
    // }
  }
}
