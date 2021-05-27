import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  final int tabNumber;
  final Function(int) tabClicked;
  BottomTab({this.tabNumber, this.tabClicked});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int selectedTabNumber = 0;

  @override
  Widget build(BuildContext context) {
    selectedTabNumber = widget.tabNumber ?? 0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.32),
                blurRadius: 30.0,
                spreadRadius: 1.2),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
            onPressed: () {
              widget.tabClicked(0);
            },
            imagePath: "assets/tab_home.png",
            isSelected: selectedTabNumber == 0 ? true : false,
          ),
          BottomTabButton(
            onPressed: () {
              widget.tabClicked(1);
            },
            imagePath: "assets/tab_search.png",
            isSelected: selectedTabNumber == 1 ? true : false,
          ),
          BottomTabButton(
            onPressed: () {
              widget.tabClicked(2);
            },
            imagePath: "assets/tab_saved.png",
            isSelected: selectedTabNumber == 2 ? true : false,
          ),
          BottomTabButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            imagePath: "assets/tab_logout.png",
            isSelected: selectedTabNumber == 3 ? true : false,
          )
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final Function onPressed;
  BottomTabButton({this.imagePath, this.isSelected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 3.0,
                    color: _isSelected
                        ? Theme.of(context).accentColor
                        : Colors.transparent))),
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
        child: Image(
          color: _isSelected ? Theme.of(context).accentColor : Colors.black,
          image: AssetImage(imagePath),
          width: 28.0,
          height: 29.0,
        ),
      ),
    );
  }
}
