import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/screens/home_page.dart';
import 'package:e_comm_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Building up the landing page class. The landing page is
//going to have a firebase initialization.

//READ THIS: Fbase has 2 levels of checking: check for connection to firebase and authentication.

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        //Snapshots are checked by firebase. This is checking for connection. If it has an error, then error message will be displayed

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error encountered ${snapshot.error}",
                style: Constants.fontsize,
              ),
            ),
          );
        }

        // If we have established our link with FBase,
        //then check for authentication
        if (snapshot.connectionState == ConnectionState.done) {
          //Once we have established a conn to Fbase, next use Streambuilder to check for authentication of user.

          //StreamBuilder is function that streams data and checks for authstate live
          return StreamBuilder(
              //instantiate authentication
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                //if stream snapshot has an error

                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                        child: Text(
                            "Error in Streamings is ${streamSnapshot.error}")),
                  );
                  //if stream snapshot is live i.e. active
                } else if (streamSnapshot.connectionState ==
                    ConnectionState.active) {
                  User _user = streamSnapshot.data;

                  if (_user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                //Builder method takes a return value only, so the 'loading' state is shown as a scaffold
                return Scaffold(
                  body: Center(
                    child: Text("Checking auth..."),
                  ),
                );
              });
        }

        // A loading screen while we wait for connection
        return Scaffold(
          body: Center(
            child: Text("Loading...."),
          ),
        );
      },
    );
  }
}
