import 'package:flutter/material.dart';

class Util {
  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  static String? fieldCannotBeEmpty(val, {fieldName}) {
    if (val.toString().trim().isEmpty || val == '') {
      return '${fieldName ?? 'field'} ' 'cannot be empty';
    } else {
      return null;
    }
  }

  static String? stringValidateWithMaxAndMinLimit(val, maxlimit, minlimit, {fieldName}) {
    if (val.toString().trim().isEmpty || val == '') {
      return '${fieldName ?? 'field'} ' 'cannot be empty';
    } else if (val.toString().trim().length > maxlimit) {
      return 'Character limit exceeded';
    } else if (val.toString().trim().length < minlimit) {
      return 'Character limit must be between $minlimit and $maxlimit';
    } else {
      return null;
    }
  }

  static String? stringValidateWithMaxAndMinLimitUserName(val, maxlimit, minlimit, {fieldName}) {
    if (val.toString().trim().isEmpty || val == '') {
      return '${fieldName ?? 'field'} ' 'cannot be empty';
    } else if (val.toString().trim().length > maxlimit) {
      return 'Character limit exceeded';
    } else if (val.toString().trim().length < minlimit) {
      return 'Character limit must be between $minlimit and $maxlimit';
    } else if (_validateUsername(val)) {
      return null;
    } else {
      return 'Invalid username format'; // Custom error message for invalid username
    }
  }

  static bool _validateUsername(String username) {
    RegExp regExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_-]{2,50}$');
    return regExp.hasMatch(username);
  }

  static String? emailOrUserNameValidate(val, maxlimit, minlimit, {fieldName}) {
    if (val.contains(".com")) {
      // email validation
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      if (val.toString().trim().isEmpty || val == '') {
        return '${fieldName ?? 'field'} ' 'cannot be empty';
      } else if (!emailRegex.hasMatch(val)) {
        return 'Invalid email';
      } else {
        return null;
      }
    } else {
      // user name validation
      if (val.toString().trim().isEmpty || val == '') {
        return '${fieldName ?? 'field'} ' 'cannot be empty';
      } else if (val.toString().trim().length > maxlimit) {
        return 'Character limit exceeded';
      } else if (val.toString().trim().length < minlimit) {
        return 'Character limit must be between $minlimit and $maxlimit';
      } else {
        return null;
      }
    }
  }

  static String? emailValidate(String val) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (val.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  static String? passwordValidate(String value, {fieldName}) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.{8,})');

    if (value.isEmpty || value == "") {
      return '${fieldName ?? 'field'} ' "cannot be empty";
    }

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters with at least one uppercase letter, one lowercase letter, and one number.';
    }

    return null;
  }

  static String? newPasswordValidate(String value, String currentPasswodVal, {fieldName}) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.{8,})');

    if (value.isEmpty || value == "") {
      return '${fieldName ?? 'field'} ' "cannot be empty";
    }

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters with at least one uppercase letter, one lowercase letter, and one number.';
    }
    if (currentPasswodVal == value) {
      return 'New password should be different from current password';
    }

    return null;
  }

  static String? confirmPassword(String value, String passwordValue, String label) {
    if (value.isEmpty) {
      return "$label " "cannot be empty";
    }
    if (value != passwordValue) {
      return "The password confirmation does not match";
    } else {
      return null;
    }
  }


  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode()); //DateFormat('MMM/dd/yyyy').format(date);
  }
}
