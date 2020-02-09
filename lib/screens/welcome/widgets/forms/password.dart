import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';

class PasswordForm extends StatelessWidget {
  final Function onSaved;
  final FocusNode node;
  final bool login;

  PasswordForm({this.onSaved, this.node, this.login = true});

  @override
  build(context) => Container(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: TextFormField(
          obscureText: true,
          focusNode: node,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              hintText: currentL10n(context).password,
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
              icon: Icon(
                Icons.lock,
                color: Colors.grey[300],
              )),
          onChanged: (val) {
            if (login) {
              return BlocProvider.of<LoginBloc>(context)
                  .add(LoginPasswordChanged(password: val));
            } else {
              return BlocProvider.of<SignupBloc>(context)
                  .add(SignupPasswordChanged(password: val));
            }
          },
          onSaved: (value) => onSaved(value.trim()),
        ),
      );
}
