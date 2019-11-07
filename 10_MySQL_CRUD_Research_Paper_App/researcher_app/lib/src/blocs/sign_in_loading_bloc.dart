import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:researcher_app/src/authentication/authentication_service.dart';
import 'package:researcher_app/src/authentication/models/user_model.dart';

class SignInLoadingBloc {
  SignInLoadingBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  void dispose() {
    _isLoadingController.close();
  }

  Future<UserModel> _signIn(Future<UserModel> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (err) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<UserModel> _signInWithParams(Future<UserModel> signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod;
    } catch (err) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<UserModel> signInAsGuest() async => await _signIn(auth.signInAsGuest);

  Future<UserModel> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);

  Future<UserModel> signInWithEmailAndPassword(
          String email, String password) async =>
      await _signInWithParams(auth.signInWithEmailAndPassword(email, password));

  Future<UserModel> createWithEmailAndPassword(
          String email, String password) async =>
      await _signInWithParams(
          auth.createUserWithEmailAndPassword(email, password));
}
