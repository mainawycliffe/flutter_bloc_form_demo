import 'package:formz/formz.dart';

enum PhoneValidationError {
  INVALID,
}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([String value = '']) : super.dirty(value);

  /// Check if a phone number if valid or not.
  /// [phoneNumber] The phone number which will be validated.
  /// Return true if the phone number is valid. Otherwise, return false.
  bool isValidPhoneNumber(String phone) {
    if (phone == null || phone.isEmpty) {
      return false;
    }
    const pattern = r'^\+(?:[0-9]●?){6,14}[0-9]$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  /// If phone number is empty, the field is valid, otherwise
  /// check if the phone number is a valid phone number
  @override
  PhoneValidationError validator(String value) {
    // phone number will be optional
    if (value?.isEmpty == true) {
      return null;
    }
    // check if phone number is valid
    return !isValidPhoneNumber(value) ? PhoneValidationError.INVALID : null;
  }
}
