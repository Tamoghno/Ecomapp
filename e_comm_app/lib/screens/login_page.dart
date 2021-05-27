import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/custombtn.dart';
import 'package:e_comm_app/custom_widgets/customtxtfield.dart';
import 'package:e_comm_app/screens/create_acc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggingin = false;

  // The func below creates user with email and password and gives string feedback if error is encountered.
  Future<String> loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmailLogin, password: userPasswordLogin);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  //Alert box takes the error from Fbase feedback as a string hence String error
  Future<void> showAlertBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Try again"))
              ],
              content: Container(
                child: Text(error),
              ),
            ));
  }

  //Calls for creating account func and shows alertbox incase of error.
  void submitForm() async {
    setState(() {
      formIsLoading = true;
    });

    String feedbackFromLogin = await loginAccount();
    if (feedbackFromLogin != null) {
      showAlertBox(feedbackFromLogin);
      setState(() {
        formIsLoading = false;
      });
    } else {
      showAlertBox(feedbackFromLogin);
      setState(() {
        formIsLoading = false;
      });
    }
  }

  @override
  void initState() {
    focusNodeForPassword = FocusNode();
    super.initState();
  }

  //Remove the focusnode
  @override
  void dispose() {
    focusNodeForPassword.dispose();
    super.dispose();
  }

  //formIsLoading is private to this class.
  bool formIsLoading = false;
  //These strings will store the user's e-mail and password required for reg

  String userEmailLogin = "";
  String userPasswordLogin = "";

  //Focusnode for moving the cursor from the email field to the password field
  FocusNode focusNodeForPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 6.0,
              ),
              Text(
                "Hey There! \n Welcome to Thrift Shop",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
              Column(
                children: [
                  CustomTextField(
                    text: "E-mail...",
                    //store the email id in the variable declared
                    onChanged: (value) {
                      userEmailLogin = value;
                    },
                    //when submitted, request to move the focus to password field
                    onSubmitted: (value) => focusNodeForPassword.requestFocus(),
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    text: "Password...",
                    isPwField: true,
                    //store the password in variable
                    onChanged: (value) {
                      userPasswordLogin = value;
                    },
                    onSubmitted: (value) {
                      submitForm();
                    },

                    //accept the focus request and start focusing on pw txt field
                    focusNode: focusNodeForPassword,
                  ),
                  DefaultCustomBtn(
                    color: Colors.red[400],
                    txt: "Login",
                    onPressed: () {
                      submitForm();
                    },
                    isLoading: isLoggingin,
                  ),
                ],
              ),
              DefaultCustomBtn(
                  color: Colors.purple[600],
                  txt: "Create Account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
