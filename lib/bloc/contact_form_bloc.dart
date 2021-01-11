import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_form_demo/models/models.dart';
import 'package:formz/formz.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc() : super(ContactFormState());

  @override
  Stream<ContactFormState> mapEventToState(
    ContactFormEvent event,
  ) async* {
    if (event is EmailChangedEvent) {
      yield _mapEmailChangedEventToState(event, state);
    }
    if (event is NameChangedEvent) {
      yield _mapNameChangedEventToState(event, state);
    }
    if (event is PhoneChangedEvent) {
      yield _mapPhoneChangedEventToState(event, state);
    }
    if (event is SubjectChangedEvent) {
      yield _mapSubjectChangedEventToState(event, state);
    }
    if (event is MessageChangedEvent) {
      yield _mapMessageChangedEventToState(event, state);
    }
    if (event is ContactFormSubmittedEvent) {
      yield* _mapContactFormSubmittedToState(event, state);
    }
  }

  ContactFormState _mapEmailChangedEventToState(
    EmailChangedEvent event,
    ContactFormState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.name,
        state.message,
        state.phone,
        state.subject,
      ]),
    );
  }

  ContactFormState _mapNameChangedEventToState(
    NameChangedEvent event,
    ContactFormState state,
  ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.message,
        state.phone,
        state.subject,
      ]),
    );
  }

  ContactFormState _mapPhoneChangedEventToState(
    PhoneChangedEvent event,
    ContactFormState state,
  ) {
    final phone = Phone.dirty(event.phone);
    return state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.email,
        state.name,
        state.message,
        phone,
        state.subject,
      ]),
    );
  }

  ContactFormState _mapSubjectChangedEventToState(
    SubjectChangedEvent event,
    ContactFormState state,
  ) {
    final subject = Subject.dirty(event.subject);
    return state.copyWith(
      subject: subject,
      status: Formz.validate([
        state.email,
        state.name,
        state.message,
        state.phone,
        subject,
      ]),
    );
  }

  ContactFormState _mapMessageChangedEventToState(
    MessageChangedEvent event,
    ContactFormState state,
  ) {
    final message = Message.dirty(event.message);
    return state.copyWith(
      message: message,
      status: Formz.validate([
        state.email,
        state.name,
        message,
        state.phone,
        state.subject,
      ]),
    );
  }

  Stream<ContactFormState> _mapContactFormSubmittedToState(
    ContactFormSubmittedEvent event,
    ContactFormState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        // simulating API call
        await Future.delayed(Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
