enum EmailSignInFormType { signIn, register }

class EmailSignInModel {
  final EmailSignInFormType formType;

  EmailSignInModel({
    this.formType = EmailSignInFormType.signIn,
  });

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  EmailSignInModel copyWith({
    EmailSignInFormType formType,
  }) {
    return EmailSignInModel(
      formType: formType ?? this.formType,
    );
  }
}
