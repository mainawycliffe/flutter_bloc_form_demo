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
    // TODO: implement mapEventToState
  }
}
