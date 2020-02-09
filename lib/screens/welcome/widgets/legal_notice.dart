import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/widgets/widgets.dart';
import 'package:autodo/theme.dart';

class LegalNotice extends StatelessWidget {
  onTap(context) {
    BlocProvider.of<LegalBloc>(context).add(LoadLegal());
    showDialog<Widget>(
        context: context,
        builder: (ctx) =>
            BlocBuilder<LegalBloc, LegalState>(builder: (context, state) {
              if (state is LegalLoading) {
                return LoadingIndicator();
              } else if (state is LegalLoaded) {
                return PrivacyPolicy(state.text);
              } else {
                Navigator.pop(context);
                return Container();
              }
            }));
  }

  @override
  build(context) => Container(
      padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
      child: Center(
          child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: currentL10n(context).legal1 + ' ',
            style: finePrint(),
          ),
          TextSpan(
            text: currentL10n(context).legal2,
            style: linkStyle(),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(
            text: ' ' + currentL10n(context).legal3 + ' ',
            style: finePrint(),
          ),
          TextSpan(
            text: currentL10n(context).legal4,
            style: linkStyle(),
            recognizer: TapGestureRecognizer()..onTap = () => onTap(context),
            semanticsLabel: 'Privacy Policy Button',
          ),
          TextSpan(
            text: ' ' + currentL10n(context).legal5,
            style: finePrint(),
          ),
        ]),
      )));
}
