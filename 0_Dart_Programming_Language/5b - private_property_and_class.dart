class LocationTest extends _SecretLocation {
  String cityName;
  String _address;
  // We can use _ to make a property or a method Private and not accessible to other Libraries
  void printAddressInfo() => print('$_address, $cityName');
}

// We can only access this private class inside this file
// Note however that if we extend this private class, all
// other files (libraries) will be able to access
// the Public properties of this Private Class
class _SecretLocation {
  double latitude;
  double longitude;
}
