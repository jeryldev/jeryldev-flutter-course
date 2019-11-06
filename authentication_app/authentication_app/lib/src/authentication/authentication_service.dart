

import 'package:authentication_app/src/authentication/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<UserModel> get onAuthStateChanged;

  Future<UserModel> currentUser();

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();

  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password);

  Future<void> resetPassword(String email);

}

class Auth implements AuthBase {
  final FirebaseAuth _authResult = FirebaseAuth.instance;

  UserModel _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }

  Stream<UserModel> get onAuthStateChanged {
    return _authResult.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<UserModel> currentUser() async {
    FirebaseUser currentUser = await _authResult.currentUser();
    return _userFromFirebase(currentUser);
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await _authResult.signInWithEmailAndPassword(
        email: email, password: password))
        .user;
    user.reload();
    if (user.isEmailVerified) {
      return _userFromFirebase(user);
    } else {
      throw PlatformException(
        // Actually, there is no such error code,
        // The message of this custom error code is in the
        // platform_exception_alert_dialog.dart file
        code: 'CUSTOM_ERROR_EMAIL_NOT_YET_VERIFIED',
      );
    }
  }

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await _authResult.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;
    await user.sendEmailVerification();
    if (user.isEmailVerified) {
      return _userFromFirebase(user);
    } else {
      throw PlatformException(
        // Actually, there is no such error code,
        // The message of this custom error code is in the
        // platform_exception_alert_dialog.dart file
        code: 'CUSTOM_ERROR_NEW_USER_EMAIL_NOT_YET_VERIFIED',
      );
    }
  }

  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        AuthResult googleAuthResult = await _authResult.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        FirebaseUser user = googleAuthResult.user;
        return _userFromFirebase(user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by the user',
      );
    }
  }

  Future<void> resetPassword(String email) async {
    await _authResult.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _authResult.signOut();
  }
}