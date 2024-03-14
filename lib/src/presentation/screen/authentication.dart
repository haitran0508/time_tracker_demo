import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/constants.dart';
import '../../../config/routes.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_state.dart';
import '../widget/hyper_link.dart';
import '../widget/rounded_button.dart';
import '../widget/text_field.dart';

enum AuthenticationProcess { signIn, signUp }

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var process = AuthenticationProcess.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: GetIt.instance.get<AuthenticationBloc>(),
          listener: (context, state) {
            if (state is SignInSuccess) {
              Navigator.pushNamed(context, RouteNames.dashBoard);
            }
            if (state is SignInFailed) {
              final snackBar = SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is SignUpFailed) {
              final snackBar = SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is SignUpSuccess) {
              setState(() {
                process = AuthenticationProcess.signIn;
              });
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Builder(
                builder: (context) {
                  switch (process) {
                    case AuthenticationProcess.signIn:
                      return _SignInSection(
                        onSignUpRequire: () => setState(
                          () => process = AuthenticationProcess.signUp,
                        ),
                      );
                    case AuthenticationProcess.signUp:
                      return _SignUpSection(
                        onSignInRequire: () => setState(
                          () => process = AuthenticationProcess.signIn,
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInSection extends StatefulWidget {
  const _SignInSection({Key? key, required this.onSignUpRequire}) : super(key: key);

  final VoidCallback onSignUpRequire;

  @override
  State<_SignInSection> createState() => _SignInSectionState();
}

class _SignInSectionState extends State<_SignInSection> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedTextField.email(onChanged: (value) => email = value!),
        const SizedBox(height: 20),
        BorderedTextField.password(onChanged: (value) => password = value!),
        const SizedBox(height: 30),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: GetIt.instance.get<AuthenticationBloc>(),
          builder: (context, state) {
            if (state is SignInInProgress) {
              return const CircularProgressIndicator();
            }
            return RoundedButton(
              label: Texts.signIn,
              color: Colors.blue,
              size: const Size(200, 50),
              onPressed: () {
                final authenBloc = GetIt.instance.get<AuthenticationBloc>();
                authenBloc.signIn(email: email, password: password);
              },
            );
          },
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(Texts.signUpSuggest),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => widget.onSignUpRequire(),
              child: const HyperLink(Texts.signUp),
            )
          ],
        )
      ],
    );
  }
}

class _SignUpSection extends StatefulWidget {
  const _SignUpSection({Key? key, required this.onSignInRequire}) : super(key: key);

  final VoidCallback onSignInRequire;

  @override
  State<_SignUpSection> createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<_SignUpSection> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BorderedTextField.email(onChanged: (value) => email = value!),
        const SizedBox(height: 20),
        BorderedTextField.password(onChanged: (value) => password = value!),
        const SizedBox(height: 30),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: GetIt.instance.get<AuthenticationBloc>(),
          builder: (context, state) {
            if (state is SignUpInProgress) {
              return const CircularProgressIndicator();
            }
            return RoundedButton(
              label: Texts.signUp,
              color: Colors.blue,
              size: const Size(200, 50),
              onPressed: () {
                final authenBloc = GetIt.instance.get<AuthenticationBloc>();
                authenBloc.signUp(email: email, password: password);
              },
            );
          },
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(Texts.signInSuggest),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => widget.onSignInRequire(),
              child: const HyperLink(Texts.signIn),
            )
          ],
        )
      ],
    );
  }
}
