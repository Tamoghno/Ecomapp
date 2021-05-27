import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/customactionbar.dart';
import 'package:e_comm_app/screens/product_page.dart';
import 'package:e_comm_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  Future _deleteItem() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.fetchUserID())
        .collection("Cart")
        .doc(_firebaseServices.productRef.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.fetchUserID())
                .collection("Cart")
                .get(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productID: "${document.id}",
                                      )));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productRef
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }
                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map _productMap = productSnap.data.data();

                              if (_productMap.length == 0) {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      "No items in cart...",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            "${_productMap['Images'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap['Shoes']}",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rs. ${_productMap['Price']}",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        _deleteItem();
                                                      },
                                                      child: Text("Remove"))
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "Size - ${document.data()['size']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                            return Container(
                              height: 50.0,
                              width: 6.0,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
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
          CustomActionBar(
            hasAbackArrow: true,
            hasTitle: true,
            title: "Cart",
          ),
        ],
      ),
    );
  }
}
