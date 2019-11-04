void main() {
  // Deliberate Error Example
  String userInputAmount = '5,500';
  double tax = 0.10;

  // double amount = double.parse(userInputAmount);
  // print('Amount net of Tax: ${amount * tax}');

  // With try catch, we can trigger an action from our Flutter app
  // in case an error is detected. For example, we could
  // display a Dialog box with an error message inside.
  try {
    // Try observing the following steps...
    double amount = double.parse(userInputAmount);
    print('Amount net of Tax: ${amount * tax}');
  } on FormatException catch (e) {
    // If the error is Format Exception, perform the following...
    print('You have entered an invalid number.');
    print(e);
  } catch (e) {
    // Else, perform the following...
    print('An error has occurred.');
    print(e);
  }
}
