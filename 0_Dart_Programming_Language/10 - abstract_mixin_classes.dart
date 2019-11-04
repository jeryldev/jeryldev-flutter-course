void main() {
  Person().inAction();
  print('\n');
  Dog().inAction();
  print('\n');
  Ostrich().inAction();
  print('\n');
  Woodpecker().inAction();
}

// Scenario: We are building multiple classes and we want some of our classes
// to have some of the methods from other classes.
// In this case, we could duplicate our code, or better yet, create an abstract class.

abstract class MammalSkills with CommonSkills {
  // void eat() => print('eating');
  // void run() => print('running');
  void warmBlooded() => print('Warm Blooded');
}

class Person extends MammalSkills {
  void talk() => print('talking');
  // void eat() => print('eat');
  // void run() => print('running');
  void inAction() {
    talk();
    eat();
    run();
    print('Go to work');
  }
}

// Dogs can also eat and run, so we can either copy those functions
// or create an abstract class and "extend" it to our classes
class Dog extends MammalSkills {
  void bark() => print('woof! woof!');
  void inAction() {
    bark();
    eat();
    run();
  }
}

// Now, what if we have another class called Ostrich
// and an abstract class called Bird.
// In this case we will be duplicating methods
// Because Ostriches can also eat and run although it is a bird.
abstract class BirdSkills with CommonSkills {
  // void eat() => print('eating');
  // void run() => print('running');
  void fly() => print('flying');
  void chirp() => print('chirp');
  void laysEggs() => print('Lays an Egg');
}

class Ostrich extends BirdSkills {
  void inAction() {
    eat();
    run();
    // Ostriches cannot fly
    // Ostriches are usually silent so I don't know if they chirp();
  }
}

// We can create a "mixin" class to avoid the duplication of the methods in multiple classes,
// Mixin is a way of reusing the code of the classes in multiple class hierarchies.
// We could then have our abstract classes use this mixin using the "with" keyword
mixin CommonSkills {
  void eat() => print('eating');
  void run() => print('running');
}

// Now, not all Birds can peck but they can still chirp
// In this case, we can create a new mixin for Pecking Birds
// The "on" keyword restricts the usage of Pecking mixin only to BirdSkills classes
mixin Pecking on BirdSkills {
  void pecking() {
    print('pecking');
    chirp();
  }
}

class Woodpecker extends BirdSkills with Pecking {
  void inAction() {
    pecking();
  }
}
