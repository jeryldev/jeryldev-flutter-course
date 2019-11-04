void main() {
  // Maps<T, T> is a key value pair so if we passed in the key (left T),
  // we will get the value (right T);
  // We use {} for Maps
  Map<String, int> familyListAge = {
    'Jeryl': 29,
    'Ara': 30,
    'Athena': 4,
    'Mavis': 2,
  };
  print(familyListAge);

  print('---------------------');

  // To access the value of a key in a Map
  print('Jeryl is ${familyListAge['Jeryl']} years old.');

  // To override a value of a key in a Map
  familyListAge['Jeryl'] = 30;

  // To add a new key value pair in a Map
  familyListAge['Garfield the Cat'] = 2;
  print(familyListAge);

  // To remove a key value pair in a Map
  familyListAge.remove('Garfield the Cat');

  print(familyListAge);

  print('---------------------');

  // To iterate the key value pairs in a Map using the functional approach
  familyListAge.forEach((x, y) => print('$x: $y'));
}
