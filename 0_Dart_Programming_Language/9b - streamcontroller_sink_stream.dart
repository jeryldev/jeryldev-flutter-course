import 'dart:async';

void main() {
  // Now that we have a background about streams, let's discuss
  // StreamController, Sink, and Stream
  // If the events of our stream comes from different parts of your program,
  // (like from user input on the username and password fields in a form)
  // and not just from a stream or futures that can traversed by an async function,
  // (like in a URL endpoint);
  // then we could use a StreamController to create and populate the stream.

  // In this case, we first create a Stream Controller
  // StreamController = Tunnel
  final StreamController usernameController = StreamController();

  // To pass in values to the "Sink", we have to use the "add" method
  // Sink = Starting point for the Inputs
  // usernameController.sink.add('myUsername');
  usernameChecker(usernameController, 'Jeryl');
  usernameChecker(usernameController, 'someUsername');

  // We then have to "listen" to the Stream for any outputs
  // Stream = End point for the Outputs
  usernameController.stream.listen(
    (username) => print(username),
    // onError accepts a function that will act in case of an error
    // Without onError, a stacktrace will be shown in the Debug Console
    // Unhandled exception:
    // Error: someUsername is not found
    onError: (username) => print('Username does not exist.'),
    // onDone accepts a function that will act upon "listening" completion
    onDone: () => print('Proceed to home page.'),
  );
}

void usernameChecker(StreamController controller, String username) {
  username == 'Jeryl'
      ? controller.sink.add(username)
      : controller.sink.addError(username);
}
