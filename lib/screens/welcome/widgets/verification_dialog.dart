import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/routes.dart';

class EmailVerificationDialog extends StatelessWidget {
  @override
  build(context) => AlertDialog(
        title: Text(currentL10n(context).verifyEmail,
            style: Theme.of(context).primaryTextTheme.title),
        content: Text(currentL10n(context).verifyBodyText,
            style: Theme.of(context).primaryTextTheme.body1),
        actions: [
          BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
            if (!(state is UserVerified)) return Container();
            return FlatButton(
              child: Text(currentL10n(context).next),
              onPressed: () => Navigator.popAndPushNamed(
                  context, AutodoRoutes.newUserScreens),
            );
          })
        ],
      );
}
