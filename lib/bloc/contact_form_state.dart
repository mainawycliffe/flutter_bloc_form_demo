part of 'contact_form_bloc.dart';

class ContactFormState extends Equatable {
  final FormzStatus status;
  final Name name;
  final Email email;
  final Phone phone;
  final Subject subject;
  final Message message;

  const ContactFormState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.subject = const Subject.pure(),
    this.message = const Message.pure(),
  });

  ContactFormState copyWith({
    FormzStatus status,
    Name name,
    Email email,
    Phone phone,
    Subject subject,
    Message message,
  }) {
    return ContactFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  ContactMessage toContactMessage() {
    return ContactMessage(
      name: name.value,
      email: email.value,
      phone: phone.value,
      subject: subject.value,
      message: message.value,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        email,
        phone,
        subject,
        message,
      ];
}
