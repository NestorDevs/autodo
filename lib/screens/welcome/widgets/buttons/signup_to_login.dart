import 'package:autodo/routes.dart';
import 'package:flutter/material.dart';

import 'package:autodo/localization.dart';
import 'package:autodo/theme.dart';

class SignupToLoginButton extends StatelessWidget {
  @override
  build(context) => Container(
        padding: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text(AutodoLocalizations.alreadyHaveAnAccount,
              style: linkStyle()),
          onPressed: () =>
              Navigator.of(context).pushNamed(AutodoRoutes.loginScreen),
        ),
      );
}
