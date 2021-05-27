import 'package:flutter/material.dart';

class SizeBoxes extends StatefulWidget {
  final List sizesList;
  final Function(String) onSelection;

  SizeBoxes({this.sizesList, this.onSelection});
  @override
  _SizeBoxesState createState() => _SizeBoxesState();
}

class _SizeBoxesState extends State<SizeBoxes> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        children: [
          for (int i = 0; i < widget.sizesList.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelection("${widget.sizesList[i]}");
                setState(() {
                  selected = i;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 6.0),
                height: 42.0,
                width: 42.0,
                decoration: BoxDecoration(
                  color: selected == i
                      ? Theme.of(context).accentColor
                      : Colors.grey[350],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  widget.sizesList[i],
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: selected == i ? Colors.white : Colors.black),
                ),
              ),
            )
        ],
      ),
    );
  }
}
