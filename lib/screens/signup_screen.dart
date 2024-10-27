import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kings_store/widgets/buttom_navigation.dart';
import 'package:kings_store/screens/coming_soon_screen.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/screens/signin_screen.dart';
import 'package:kings_store/services/database.dart';
import 'package:kings_store/services/shared_pref.dart';
import 'package:kings_store/widgets/buttons.dart';
import 'package:random_string/random_string.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  String fullname = '';
  String email = '';
  String password = '';

  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // the reg function

  registration() async {
    if (fullname != "" && email != "" && password != "") {
      setState(() {
        isLoading = true; // Start showing loading indicator
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Registered Successfully")));

        // saving the user info into database
        String Id = randomAlphaNumeric(10);

        await SharedPreferenceHelper().getUserId(Id);
        await SharedPreferenceHelper().getUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().getUserName(fullnamecontroller.text);
        await SharedPreferenceHelper()
            .getUserImage("assets/images/imageplaceholder.jpg");

        Map<String, dynamic> userInfoMap = {
          "Name": fullnamecontroller.text,
          "Email": mailcontroller.text,
          "id": Id,
          "Image": "assets/images/imageplaceholder.jpg",
        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        // end saving the user info into database

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()));
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);

        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("No user found for this email")));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Incorrect password!")));
        }
      } finally {
        setState(() {
          isLoading = false; // Stop showing loading indicator
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Something went wrong Try again")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/logo2.png"),
                    const SizedBox(height: 25),
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: fullnamecontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: mailcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                          size: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 18,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'the password field is empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(),
                    CustomButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (fullnamecontroller.text != "" &&
                              mailcontroller.text != "" &&
                              passwordcontroller.text != "") {
                            setState(() {
                              fullname = fullnamecontroller.text;
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                            });
                          } else if (mailcontroller.text == "" &&
                              passwordcontroller.text == "") {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: Text("The field(s) is empty"),
                                  );
                                });
                          }
                          registration();
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Or'),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Sign Up with'),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ComingSoon()));
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset("assets/images/kingsChat.png"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
