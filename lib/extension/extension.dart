extension Validator on String {
  bool validateEmail() {
    return RegExp(r'[a-zA-Z0-9\.\-\_]+[@][-\a-z]+[\.][a-z]{2,3}')
        .hasMatch(this);
  }

  bool validatePhone() {
    return RegExp(r'[+][0-9]{3}[-\][0-9]{10}').hasMatch(this);
  }
}
