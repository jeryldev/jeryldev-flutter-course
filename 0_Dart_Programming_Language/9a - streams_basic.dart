void main() {
  // With future, as soon as the Future function is complete, it's already done.
  // What if we want to keep returning any newly added values
  // or events (ex. user click, internet connection change) as soon as they become available?
  // Or, what if we want to keep returning any changes in values or events as soon as they become available?
  // Another example is, what if we need to track for the sending and the receiving of the information
  // For these scenarios, we can use Streams in Dart.

  // There are 2 types of Streams in Dart
  // 1 - Single subscription streams - This is a stream can only be listened to, once.
  // 2 - Broadcast streams - More than one listener can listen at the same time

  // Basic Stream example
  List<String> myFamilyList = ['Jeryl', 'Ara', 'Athena', 'Mavis'];
  Stream familyStream = listStream(myFamilyList);
  // What happens here is that the members are printed one by one.
  // As soon as all the members are shown, the stream gets closed after the listen is complete
  familyStream.listen((member) => print(member));
}

// We use iterable if we do not know if the Parameter to be added is a List or a Set
// async is for Future. async* is for Stream
Stream<String> listStream(List<String> list) async* {
  // yield keyword vs return keyword
  // yield - this keeps the function waiting for more values or events
  // return - closes everything. this means that we are done with the function
  for (var member in list) {
    yield member;
  }
}
