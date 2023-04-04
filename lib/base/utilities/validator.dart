class Validator {
  static String? emailValidator(String? email) {
    if (email == null) {
      return "Enter email";
    }
    String pattern = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regExp = RegExp(pattern);

    // Matching the user Email id with regexp pattern
    if (email.trim().isEmpty) {
      return "Please enter email.";
    }
    // If e-mail textform field havenot any input
    else if (!regExp.hasMatch(email)) {
      return "Please enter valid email.";
    }

    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null) {
      return "Enter password";
    }
    if (password.isEmpty) {
      return "Password required.";
    } else if (password.length < 8) {
      return "Password must be at least 8 character.";
    }
    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber == null) {
      return "Enter phone number";
    }
    if (int.tryParse(phoneNumber) == null || phoneNumber.length != 10) {
      return "Please enter valid phone number";
    }
    return null;
  }

  static String? addressValidator(String? address) {
    if (address == null) {
      return "Enter address";
    }
    if (address.trim().isEmpty) {
      return "Please enter address";
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null) {
      return "This field cannot be empty";
    }
    if (name.trim().isEmpty || name.length < 2) {
      return "Please fill this field";
    }
    return null;
  }
}
