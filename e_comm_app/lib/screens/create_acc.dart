import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/custombtn.dart';
import 'package:e_comm_app/custom_widgets/customtxtfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //Alert box takes the error from Fbase feedback as a string hence String error
  Future<void> showAlertBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
          );
        });
  }

  // The func below creates user with email and password and gives string feedback if error is encountered.
  Future<String> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmailRegister, password: userPasswordRegister);
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

  //Calls for creating account func and shows alertbox incase of error.
  void submitForm() async {
    setState(() {
      formIsLoading = true;
    });

    String feedbackFromSubmission = await createAccount();
    if (feedbackFromSubmission != null) {
      showAlertBox(feedbackFromSubmission);
      setState(() {
        formIsLoading = false;
      });
    }
  }

  //formIsLoading is private to this class.
  bool formIsLoading = false;
  //These strings will store the user's e-mail and password required for reg

  String userEmailRegister = "";
  String userPasswordRegister = "";

  //Focusnode for moving the cursor from the email field to the password field
  FocusNode focusNodeForPassword;
  //Initialize Focusnode
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

              //TOPMOST AREA TEXT
              Text(
                "Create an account with us, \n We keep you first!",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
              //Input text fields for email and pw

              Column(
                children: [
                  CustomTextField(
                    text: "E-mail...",
                    //store the email id in the variable declared
                    onChanged: (value) {
                      userEmailRegister = value;
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
                      userPasswordRegister = value;
                    },
                    onSubmitted: (value) {
                      submitForm();
                    },

                    //accept the focus request and start focusing on pw txt field
                    focusNode: focusNodeForPassword,
                  ),
                  DefaultCustomBtn(
                    color: Colors.teal,
                    txt: "Create Account",
                    onPressed: () {
                      submitForm();
                      //When we press the button, we declare that now we are loading something
                      setState(() {
                        formIsLoading = true;
                      });
                    },
                    isLoading: formIsLoading,
                  ),
                ],
              ),
              DefaultCustomBtn(
                color: Colors.black,
                txt: "Back to Login",
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    formIsLoading = false;
                  });
                },
                isLoading: formIsLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
