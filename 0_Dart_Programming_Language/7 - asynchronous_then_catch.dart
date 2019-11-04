import 'dart:html';

void main() {
  // Two ways to fetch data from a server
  // 1. Synchronous - app will freeze until the data download is complete
  // 2. Asynchronous - data download will happen on the background.
  //                 - This will allow the app to continue operating and perform other tasks
  //                 - Once the download is complete (either success or fail),
  //                 - it will call back the function and will perform anything it still needs to do.

  // var result =
  //     HttpRequest.getString('https://jsonplaceholder.typicode.com/posts/1');

  // There are a couple of Functions we can use to work on the result variable
  // result.then(handleSuccess);
  // result.catchError(handleError);

  // We can further compact our code by doing the following:
  HttpRequest.getString('https://jsonplaceholder.typicode.com/posts/1')
      .then((String response) {
    print('Request is successful.');
    print(response);
  }).catchError((String response) {
    print('Request is not successful.');
    print(response);
  });

  // This will be printed first, while the result variable
  // is being handled for success and error in the background
  print('main function has ended.');
}

// Function to handle successful request
void handleSuccess(String response) {
  print('Request was successful.');
  print(response);
}

// Function to handle failed request
void handleError(String response) {
  print('Request was not successful.');
  print(response);
}
