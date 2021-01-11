import 'package:flutter_bloc_form_demo/bloc/contact_form_bloc.dart';
import 'package:flutter_bloc_form_demo/models/models.dart';
import 'package:formz/formz.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('ContactFormBloc', () {
    blocTest(
      'emits [submissionInProgress, submissionSuccess] '
      'when phone number is empty',
      build: () {
        return ContactFormBloc();
      },
      act: (bloc) => bloc
        ..add(NameChangedEvent("John Doe"))
        ..add(EmailChangedEvent("user@example.com"))
        ..add(SubjectChangedEvent("Subject"))
        ..add(MessageChangedEvent("Message To The User"))
        ..add(ContactFormSubmittedEvent()),
      expect: <ContactFormState>[
        ContactFormState(
          status: FormzStatus.invalid,
          name: Name.dirty("John Doe"),
        ),
        ContactFormState(
          status: FormzStatus.invalid,
          name: Name.dirty("John Doe"),
          email: Email.dirty("user@example.com"),
        ),
        ContactFormState(
          status: FormzStatus.invalid,
          name: Name.dirty("John Doe"),
          email: Email.dirty("user@example.com"),
          subject: Subject.dirty("Subject"),
        ),
        ContactFormState(
          status: FormzStatus.valid,
          name: Name.dirty("John Doe"),
          email: Email.dirty("user@example.com"),
          subject: Subject.dirty("Subject"),
          message: Message.dirty("Message To The User"),
        ),
        ContactFormState(
          status: FormzStatus.submissionInProgress,
          name: Name.dirty("John Doe"),
          email: Email.dirty("user@example.com"),
          subject: Subject.dirty("Subject"),
          message: Message.dirty("Message To The User"),
        ),
        ContactFormState(
          status: FormzStatus.submissionSuccess,
          name: Name.dirty("John Doe"),
          email: Email.dirty("user@example.com"),
          subject: Subject.dirty("Subject"),
          message: Message.dirty("Message To The User"),
        ),
      ],
    );

    group('ContactFormBloc', () {
      blocTest(
        'Validates Phone No Successfully',
        build: () {
          return ContactFormBloc();
        },
        act: (bloc) => bloc
          ..add(NameChangedEvent("John Doe"))
          ..add(EmailChangedEvent("user@example.com"))
          ..add(SubjectChangedEvent("Subject"))
          ..add(MessageChangedEvent("Message To The User"))
          ..add(PhoneChangedEvent("12345678")) // invalid phone no
          ..add(PhoneChangedEvent("+254712345678")) // valid phone no
          ..add(ContactFormSubmittedEvent()),
        expect: <ContactFormState>[
          ContactFormState(
            status: FormzStatus.invalid,
            name: Name.dirty("John Doe"),
          ),
          ContactFormState(
            status: FormzStatus.invalid,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
          ),
          ContactFormState(
            status: FormzStatus.invalid,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
          ),
          ContactFormState(
            status: FormzStatus.valid,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
            message: Message.dirty("Message To The User"),
          ),
          ContactFormState(
            status: FormzStatus.invalid,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
            message: Message.dirty("Message To The User"),
            phone: Phone.dirty("12345678"),
          ),
          ContactFormState(
            status: FormzStatus.valid,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
            message: Message.dirty("Message To The User"),
            phone: Phone.dirty("+254712345678"),
          ),
          ContactFormState(
            status: FormzStatus.submissionInProgress,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
            message: Message.dirty("Message To The User"),
            phone: Phone.dirty("+254712345678"),
          ),
          ContactFormState(
            status: FormzStatus.submissionSuccess,
            name: Name.dirty("John Doe"),
            email: Email.dirty("user@example.com"),
            subject: Subject.dirty("Subject"),
            message: Message.dirty("Message To The User"),
            phone: Phone.dirty("+254712345678"),
          ),
        ],
      );
    });
  });
}
