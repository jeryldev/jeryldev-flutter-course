import 'package:authentication_app/src/widgets/platform_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
  );

  static String _message(PlatformException exception) {
    if (exception.message ==
        'PERMISSION_DENIED: Missing or insufficient permissions.') {
      if (exception.code == 'Error performing setData') {
        return 'Missing or insufficient permissions';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String>_errors = {
    'CUSTOM_ERROR_EMAIL_NOT_YET_VERIFIED':
        'Verify your e-mail to finish signing up for this app.',
    'CUSTOM_ERROR_NEW_USER_EMAIL_NOT_YET_VERIFIED':
        'Thank you for choosing my Login App. Verify your e-mail to finish signing up.',
    'ERROR_WRONG_PASSWORD': 'The password is invalid.',

    /// Access the FirebaseAuth.instance.createUserWithEmailAndPassword
    /// to view the list of Error codes
    ///
    ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    ///   • `ERROR_INVALID_EMAIL` - If the email address is malformed.
    ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
    ///
    /// Access the FirebaseAuth.instance.signInWithEmailAndPassword
    /// to view the list of Error codes
    ///
    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  };
}