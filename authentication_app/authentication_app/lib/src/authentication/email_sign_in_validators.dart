import 'dart:async';

class EmailSignInValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      email.contains('@')
          ? sink.add(email)
          : sink.addError('Enter a valid email');
    },
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      password.length > 4
          ? sink.add(password)
          : sink.addError('Password must be at least 4 characters.');
    },
  );
}
