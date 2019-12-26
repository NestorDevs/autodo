import 'package:autodo/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/theme.dart';
import 'form.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key key}) : super(key: key);
  
  @override 
  build(context) => Container(  
    decoration: scaffoldBackgroundGradient(),
    child: Scaffold(  
      appBar: AppBar(  
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[300]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AutodoLocalizations.signup.toUpperCase(),
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) => SignupForm(),
      ),
      backgroundColor: Colors.transparent,
    )
  );
}