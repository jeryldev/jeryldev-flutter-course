import 'dart:async';
import 'dart:html';

void main() {
  userPost();

  // Since this program is asynchronous in nature,
  // The print will be displayed ahead of the function of Future return type.
  print('main function has ended.');
}

// Return a Future object that will eventually probably have the value (or error)
// Basically, we are telling that this is an "async"-hronous function and
// we are "await"-ing to hear a response from the url String
Future userPost() async {
  // Use Try Catch for error handling
  try {
    final response = await HttpRequest.getString(
        'https://jsonplaceholder.typicode.com/posts/1');

    print('Request was successful.');
    print(response);
  } catch (error) {
    print('Request was not successful.');
    print(error);
  }

  // the print will only be displayed after the "await" is completed.
  print('The userPost function has ended.');
}
