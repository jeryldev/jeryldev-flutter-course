import 'dart:async';

class EmailSignInValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@') && email.contains('.com')) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      (password.length > 4)
          ? sink.add(password)
          : sink.addError('Password must be at least 5 characters.');
    },
  );
}
