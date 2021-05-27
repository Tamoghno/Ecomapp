import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/screens/cart_page.dart';
import 'package:e_comm_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasAbackArrow;
  final bool hasTitle;
  final bool hasBg;
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseServices _firebaseservices = FirebaseServices();
  CustomActionBar({this.hasAbackArrow, this.title, this.hasTitle, this.hasBg});
  @override
  Widget build(BuildContext context) {
    String _title = title ?? "Home";
    bool _hasAbackArrow = hasAbackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBg = hasBg ?? true;
    int number = 0;
    return Container(
      decoration: BoxDecoration(
        gradient: _hasBg
            ? LinearGradient(
                colors: [Colors.grey[300], Colors.white.withOpacity(0)],
                begin: Alignment(0, 0),
                end: Alignment(0, 1))
            : null,
      ),
      padding:
          EdgeInsets.only(left: 30.0, top: 55.0, right: 30.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasAbackArrow == true)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Image(
                  image: AssetImage("assets/back_arrow.png"),
                ),
              ),
            ),
          if (_hasTitle == true)
            Text(
              _title,
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    color: number != 0
                        ? Colors.black
                        : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(12.0)),
                child: StreamBuilder(
                  stream: _userRef
                      .doc(_firebaseservices.fetchUserID())
                      .collection("Cart")
                      .snapshots(),
                  builder: (context, snapshot) {
                    int _itemsNumber = 0;
                    if (snapshot.connectionState == ConnectionState.active) {
                      List _docs = snapshot.data.docs;
                      _itemsNumber = _docs.length;
                      number = _itemsNumber;
                    }

                    return Text(
                      "$_itemsNumber",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
