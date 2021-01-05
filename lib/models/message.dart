import 'package:formz/formz.dart';

enum MessageValidationError {
  EMPTY,
}

class Message extends FormzInput<String, MessageValidationError> {
  const Message.pure() : super.pure('');
  const Message.dirty([String value = '']) : super.dirty(value);

  @override
  MessageValidationError validator(String value) {
    if (value?.isEmpty == true) {
      return MessageValidationError.EMPTY;
    }
    return null;
  }
}
