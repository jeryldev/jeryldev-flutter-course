void main() {
  // List<T> is similar to Arrays where T is the Type
  // The order of the list will depend on how we instantiate it.
  // We use [] for Lists
  List<String> familyList = ['Jeryl', 'Ara'];
  print(familyList); // [Jeryl, Ara]

  // Cool thing about List is that we can dynamically grow our List
  // unlike the traditional Array in other programming languages
  familyList.add('Athena');
  familyList.add('Mavis');
  familyList.add('Garfield the Cat');
  print(familyList); // [Jeryl, Ara, Athena, Mavis, Garfield the Cat]

  // To override a value of an item in a List
  familyList[4] = 'Garfield';
  print(familyList); // [Jeryl, Ara, Athena, Mavis, Garfield]

  // To remove a key value pair in a Map
  familyList.remove(familyList[4]);
  print(familyList); // [Jeryl, Ara, Athena, Mavis]

  print('---------------------');

  // There will be an exception thrown if we try to add an incorrect type to the list
  // The argument type 'int' can't be assigned to the parameter type 'String'.dart(argument_type_not_assignable)
  // familyList.add(3000);

  // To access 'Athena' in the list
  // Keep in mind that the index of a list starts with 0
  print(familyList[2]); // Athena

  print('---------------------');

  // Iterate from the list
  // For In Loop
  for (var item in familyList) {
    print(item); // Jeryl // Ara // Athena // Mavis
  }

  print('---------------------');

  // For Loop
  for (var i = 0; i < familyList.length; i++) {
    print(familyList[i]); // Jeryl // Ara // Athena // Mavis
  }

  print('---------------------');

  // Using forEach method.
  // Functional Approach inspired by JavaScript ES6 (EcmaScript 6 standard) syntax.
  // With this approach, we use the forEach method and then pass in an
  // "anonymous function" to indicate the operation to be performed with each item.
  familyList.forEach((x) => print(x)); // Jeryl // Ara // Athena // Mavis

  print('---------------------');

  // Using Map method.
  // Using Functional Approach, I will make a new familyList that contains all
  // the names from the familyList, and all are capitalized (or in uppercase)
  List<String> uppercaseFamilyList =
      familyList.map((x) => x.toUpperCase()).toList();

  print(uppercaseFamilyList);

  print('---------------------');

  // Using the Map method, we were able to create a copy of the list easily
  // while keeping the original list intact.
  print(familyList);

  print('---------------------');
}
