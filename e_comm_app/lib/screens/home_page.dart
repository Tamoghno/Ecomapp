import 'package:e_comm_app/custom_widgets/bottom_tabs.dart';
import 'package:e_comm_app/tabs/hometab.dart';
import 'package:e_comm_app/tabs/savedtab.dart';
import 'package:e_comm_app/tabs/searchtab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController tabsPageController;
  int _tabNumber = 0;

  @override
  void initState() {
    tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _tabNumber = num;
                });
              },
              children: [HomeTab(), SearchTab(), SavedTab()],
            ),
          ),
          BottomTab(
            tabNumber: _tabNumber,
            tabClicked: (num) {
              tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInCubic);
            },
          )
        ],
      ),
    );
  }
}
