import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_form_demo/bloc/contact_form_bloc.dart';
import 'package:formz/formz.dart';

import 'models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ContactFormBloc(),
        child: ContactFormPage(),
      ),
    );
  }
}

class ContactFormPage extends StatelessWidget {
  const ContactFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Form"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Text(
                "Fill in the form below to contact us",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 8.0),
              _Name(),
              const SizedBox(height: 8.0),
              _Email(),
              const SizedBox(height: 8.0),
              _Phone(),
              const SizedBox(height: 8.0),
              _Subject(),
              const SizedBox(height: 8.0),
              _Message(),
              const SizedBox(height: 8.0),
              _SendButton(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  String errorText(Name _name) {
    if (_name.invalid) {
      return "Name is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name?.value,
          keyboardType: TextInputType.name,
          autofillHints: [AutofillHints.name],
          onChanged: (value) =>
              context.read<ContactFormBloc>().add(NameChangedEvent(value)),
          decoration: InputDecoration(
            labelText: "Name",
            errorText: errorText(state.name),
          ),
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  String errorText(Email _email) {
    if (_email.invalid) {
      if (_email.error == EmailValidationError.INVALID) {
        return "A valid email is required";
      }
      return "Email is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email?.value,
          keyboardType: TextInputType.emailAddress,
          autofillHints: [AutofillHints.email],
          onChanged: (value) =>
              context.read<ContactFormBloc>().add(EmailChangedEvent(value)),
          decoration: InputDecoration(
            labelText: "Email Address",
            errorText: errorText(state.email),
          ),
        );
      },
    );
  }
}

class _Phone extends StatelessWidget {
  String errorText(Phone _phone) {
    if (_phone.invalid) {
      if (_phone.error == PhoneValidationError.INVALID) {
        return "A valid phone no is required";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.phone?.value,
          keyboardType: TextInputType.emailAddress,
          autofillHints: [AutofillHints.telephoneNumber],
          onChanged: (value) =>
              context.read<ContactFormBloc>().add(PhoneChangedEvent(value)),
          decoration: InputDecoration(
            labelText: "Phone No.",
            errorText: errorText(state.phone),
          ),
        );
      },
    );
  }
}

class _Subject extends StatelessWidget {
  String errorText(Subject _subject) {
    if (_subject.invalid) {
      return "Subject is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.subject != current.subject,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.subject?.value,
          onChanged: (value) =>
              context.read<ContactFormBloc>().add(SubjectChangedEvent(value)),
          decoration: InputDecoration(
            labelText: "Subject",
            errorText: errorText(state.subject),
          ),
        );
      },
    );
  }
}

class _Message extends StatelessWidget {
  String errorText(Message _message) {
    if (_message.invalid) {
      return "Message is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.message != current.message,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.message?.value,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          minLines: 2,
          onChanged: (value) =>
              context.read<ContactFormBloc>().add(MessageChangedEvent(value)),
          decoration: InputDecoration(
            labelText: "Message",
            errorText: errorText(state.message),
          ),
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  String errorText(Message _message) {
    if (_message.invalid) {
      return "Message is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          onPressed: () =>
              context.read<ContactFormBloc>().add(ContactFormSubmittedEvent()),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: _FormLabel(),
        );
      },
    );
  }
}

class _FormLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactFormBloc, ContactFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send),
            const SizedBox(width: 5.0),
            Text("Send Message")
          ],
        );
      },
    );
  }
}
