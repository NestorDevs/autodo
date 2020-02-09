import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';
import '../new_user_setup/screen.dart';
import '../../widgets/barrel.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  FocusNode _emailNode, _passwordNode;

  @override
  void initState() {
    _emailNode = FocusNode()..requestFocus();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  build(context) => BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupError) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentL10n(context).loginFailure,
                      ),
                      Icon(Icons.error)
                    ],
                  ),
                  duration: Duration(
                      hours:
                          1), // overkill to make sure that it never goes away
                ),
              );
          } else if (state is SignupLoading) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currentL10n(context).signingUpEllipsis),
                      CircularProgressIndicator(),
                    ],
                  ),
                  duration: Duration(
                      hours:
                          1), // overkill to make sure that it never goes away
                ),
              );
          } else if (state is VerificationSent) {
            Scaffold.of(context).hideCurrentSnackBar();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(currentL10n(context).verificationSent,
                    style: Theme.of(context).primaryTextTheme.title),
                content: Text(currentL10n(context).verificationDialogContent,
                    style: Theme.of(context).primaryTextTheme.body1),
                actions: [
                  FlatButton(
                    child: Text(currentL10n(context).back,
                        style: Theme.of(context).primaryTextTheme.button),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          } else if (state is SignupSuccess || state is UserVerified) {
            Scaffold.of(context).hideCurrentSnackBar();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewUserScreen(),
                ));
          }
        },
        child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) => Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: ListView(
                      children: <Widget>[
                        EmailForm(
                            onSaved: (val) => _email = val,
                            node: _emailNode,
                            nextNode: _passwordNode,
                            login: false),
                        PasswordForm(
                          onSaved: (val) => _password = val,
                          node: _passwordNode,
                          login: false,
                        ),
                        (state is SignupError)
                            ? ErrorMessage(state.errorMsg)
                            : Container(),
                        LegalNotice(),
                        SignupSubmitButton(onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            BlocProvider.of<SignupBloc>(context).add(
                                SignupWithCredentialsPressed(
                                    email: _email, password: _password));
                          }
                        }),
                        PasswordResetButton(),
                        SignupToLoginButton(),
                      ],
                    )))),
      );
}
