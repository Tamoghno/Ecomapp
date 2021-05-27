//import 'package:e_comm_app/constants.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Text("Create Account"),
      margin: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 25.0,
      ),
    );
  }
}

class DefaultCustomBtn extends StatelessWidget {
//Custom text and colours for the button are defined here. Just call for the DefaultCustomBtn() and pass color and txt to it.

  final Color color;
  final String txt;
  final Function onPressed;
  final bool isLoading;
  DefaultCustomBtn({this.color, this.txt, this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    //by default, we are not loading anything, hence false.
    bool _isLoading = isLoading ?? false;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 16.0),
        child: Stack(children: [
          //an indicator and button are inside the stack
          //Using the visibility widget, we control when to show which.
          Visibility(visible: _isLoading, child: CircularProgressIndicator()),
          Visibility(
            visible: _isLoading ? false : true,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(txt),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 65.0, vertical: 12.0)),
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)))),
            ),
          ),
        ]));
  }
}
