import 'dart:async';
import 'package:complete_login_setup/src/authentication/models/email_sign_in_model.dart';
import 'package:complete_login_setup/src/blocs/email_sign_in_validators.dart';
import 'package:complete_login_setup/src/blocs/sign_in_loading_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class EmailSignInBloc with EmailSignInValidators {
  EmailSignInBloc({@required this.signInBloc});

  final SignInLoadingBloc signInBloc;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void updateWith({
    EmailSignInFormType formType,
  }) {
    // update model
    _model = _model.copyWith(
      formType: formType,
    );
    _modelController.add(_model);
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      formType: formType,
    );
  }

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Retrieve data from Stream
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Observable.combineLatest2(
        email,
        password,
        (e, p) => true,
      );

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Future<void> submit() async {
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await signInBloc.signInWithEmailAndPassword(
            _email.value, _password.value);
      } else {
        await signInBloc.createWithEmailAndPassword(
            _email.value, _password.value);
      }
    } catch (err) {
      rethrow;
    }
  }

  void dispose() {
    _email.close();
    _password.close();
    _modelController.close();
  }
}
