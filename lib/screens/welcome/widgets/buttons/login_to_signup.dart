import 'package:autodo/routes.dart';
import 'package:flutter/material.dart';

import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/theme.dart';

class LoginToSignupButton extends StatelessWidget {
  @override
  build(context) => Container(
        padding: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text(currentL10n(context).createAnAccount, style: linkStyle()),
          onPressed: () =>
              Navigator.of(context).pushNamed(AutodoRoutes.signupScreen),
        ),
      );
}
