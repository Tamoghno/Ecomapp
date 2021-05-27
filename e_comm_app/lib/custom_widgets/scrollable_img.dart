import 'package:flutter/material.dart';

class ScrollableImages extends StatefulWidget {
  final List imgList;
  ScrollableImages({this.imgList});
  @override
  _ScrollableImagesState createState() => _ScrollableImagesState();
}

class _ScrollableImagesState extends State<ScrollableImages> {
  int selectedPageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 390.0,
          child: PageView(
            onPageChanged: (num) {
              setState(() => selectedPageNumber = num);
            },
            children: [
              for (var i = 0; i < widget.imgList.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imgList[i]}",
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.imgList.length; i++)
                AnimatedContainer(
                  duration: Duration(milliseconds: 280),
                  curve: Curves.easeInCirc,
                  margin: EdgeInsets.all(6.0),
                  width: selectedPageNumber == i ? 25.0 : 15.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(13.0)),
                )
            ],
          ),
        )
      ],
    );
  }
}
