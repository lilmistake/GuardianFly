import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Container(
                width: 400,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _logoWidget(),
                        const _ContinuteWithGoogleButton()
                      ]),
                ))),
      ),
    );
  }

  Row _logoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Image.network(
            "https://i.imgur.com/0aIlCXu.png",
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}

class _ContinuteWithGoogleButton extends StatelessWidget {
  const _ContinuteWithGoogleButton();

  handleButtonClick(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    GoogleSignInAccount? user = await googleSignIn.signIn();

    if (user == null && context.mounted) {
      return showErrorSnackBar(context);
    }
  }

  showErrorSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        SizedBox(
          width: 5,
        ),
        Text("Sign in failed, please try again later."),
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                  spreadRadius: 1)
            ]),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => handleButtonClick(context),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.network(
                    "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png",
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Continue with Google",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}