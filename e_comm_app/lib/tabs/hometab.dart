import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/customactionbar.dart';
import 'package:e_comm_app/custom_widgets/product_card.dart';
import 'package:e_comm_app/screens/product_page.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  //Fbase product reference instance
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Center(
            child: FutureBuilder(
          future: _productRef.get(),
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
        )),
        CustomActionBar(
          title: "Home",
        ),
      ]),
    );
  }
}
