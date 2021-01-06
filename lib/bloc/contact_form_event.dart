part of 'contact_form_bloc.dart';

abstract class ContactFormEvent extends Equatable {
  const ContactFormEvent();

  @override
  List<Object> get props => [];
}

class NameChangedEvent extends ContactFormEvent {
  final String name;

  const NameChangedEvent(this.name);

  @override
  List<Object> get props => [name];
}

class EmailChangedEvent extends ContactFormEvent {
  final String email;

  const EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PhoneChangedEvent extends ContactFormEvent {
  final String phone;

  const PhoneChangedEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class SubjectChangedEvent extends ContactFormEvent {
  final String subject;

  const SubjectChangedEvent(this.subject);

  @override
  List<Object> get props => [subject];
}

class MessageChangedEvent extends ContactFormEvent {
  final String message;

  const MessageChangedEvent(this.message);

  @override
  List<Object> get props => [message];
}

class ContactFormSubmittedEvent extends ContactFormEvent {
  const ContactFormSubmittedEvent();
}
