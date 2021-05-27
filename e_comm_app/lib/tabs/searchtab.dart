import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/customtxtfield.dart';
import 'package:e_comm_app/custom_widgets/product_card.dart';
import 'package:e_comm_app/screens/product_page.dart';
import 'package:e_comm_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final String addon = "uf8ff";
  String _searchInput = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchInput.isEmpty)
            Center(
              child: Text(
                "Search Results",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
              ),
            )
          else
            FutureBuilder(
              future: _firebaseServices.productRef.orderBy("Search").startAt(
                  // ignore: unnecessary_brace_in_string_interps
                  [_searchInput]).endAt([_searchInput]).get(),
              builder: (context, snapshot) {
                //snapshot error check
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "Error encountered :${snapshot.error}",
                        style: Constants.fontsize,
                      ),
                    ),
                  );
                }
                //if snapshot connection is done, redirect to Product page
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                      padding: EdgeInsets.only(top: 112.0, bottom: 15.0),
                      children: snapshot.data.docs.map<Widget>((document) {
                        return ProductCard(
                          title: document.data()['Shoes'],
                          imageUrl: document.data()['Images'][0],
                          price: "Rs. ${document.data()['Price']}",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          productID: document.id,
                                        )));
                          },
                        );
                      }).toList());
                }
                //Loading indicator
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: CustomTextField(
              text: "Search",
              onSubmitted: (value) {
                setState(() {
                  _searchInput = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
