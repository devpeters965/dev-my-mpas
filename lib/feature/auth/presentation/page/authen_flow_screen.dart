import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_track/feature/auth/presentation/page/principal_maps.dart';
import 'package:real_track/feature/auth/presentation/widget/form/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:real_track/feature/auth/presentation/widget/form/connection/sign_in.dart';

class AuthenticationFlowScreen extends StatelessWidget {
  const AuthenticationFlowScreen({super.key});
  static String id = 'main screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return rincipalView();
          } else {
            return  BlocProvider(
              create: (context) => AuthenticationBloc(),
              child: const SignIn(),
            );
          }
        },
      ),
    );
  }
}
