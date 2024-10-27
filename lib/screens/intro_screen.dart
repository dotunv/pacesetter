import 'package:flutter/material.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/screens/signin_screen.dart';
import 'package:kings_store/screens/signup_screen.dart';
import 'package:kings_store/widgets/buttons.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/logo2.png"),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Sign In as an existing user or Sign Up to create an account",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 90,
                ),
                CustomButton(
                    text: "Create an account",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    }),
                login(),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignInPage()));
        },
        child: const Text(
          "Login",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
