import 'package:formz/formz.dart';

enum NameValidationError {
  EMPTY,
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    if (value?.isEmpty == true) {
      return NameValidationError.EMPTY;
    }
    return null;
  }
}
