import 'package:formz/formz.dart';

enum SubjectValidationError {
  EMPTY,
}

class Subject extends FormzInput<String, SubjectValidationError> {
  const Subject.pure() : super.pure('');
  const Subject.dirty([String value = '']) : super.dirty(value);

  @override
  SubjectValidationError validator(String value) {
    if (value?.isEmpty == true) {
      return SubjectValidationError.EMPTY;
    }
    return null;
  }
}
