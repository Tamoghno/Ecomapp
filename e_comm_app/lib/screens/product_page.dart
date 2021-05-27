import 'package:e_comm_app/constants.dart';
import 'package:e_comm_app/custom_widgets/customactionbar.dart';
import 'package:e_comm_app/custom_widgets/scrollable_img.dart';
import 'package:e_comm_app/custom_widgets/sizes_box.dart';
import 'package:e_comm_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productID;
  ProductPage({this.productID});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final SnackBar _snackBar = SnackBar(content: Text("Product added to cart"));
  final SnackBar _savedsnackBar =
      SnackBar(content: Text("Product Saved to Cart"));
  FirebaseServices _firebaseservices = FirebaseServices();
  Future _addToCart() {
    return _firebaseservices.userRef
        .doc(_firebaseservices.fetchUserID())
        .collection("Cart")
        .doc(widget.productID)
        .set({"size": selectedProductSize});
  }

  Future _addToSaved() {
    return _firebaseservices.userRef
        .doc(_firebaseservices.fetchUserID())
        .collection("Cart")
        .doc(widget.productID)
        .set({"size": selectedProductSize});
  }

  String selectedProductSize = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: FutureBuilder(
            future: _firebaseservices.productRef.doc(widget.productID).get(),
            builder: (context, snapshot) {
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
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                //images and sizes list
                final List imgList = documentData["Images"];
                final List sizesList = documentData['Sizes'];
                selectedProductSize = sizesList[0];

                return ListView(
                  children: [
                    ScrollableImages(
                      imgList: imgList,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(documentData['Shoes'],
                          style: Constants.boldHeading),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(
                        "Rs. ${documentData['Price']}",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(
                        documentData['Description'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20.0),
                      child: Text(
                        "Select Size",
                        style: Constants.fontsize,
                      ),
                    ),
                    SizeBoxes(
                      sizesList: sizesList,
                      onSelection: (size) {
                        selectedProductSize = size;
                      },
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addToSaved();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_savedsnackBar);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 24.0, top: 24.0, bottom: 15.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(8.0)),
                            alignment: Alignment.center,
                            height: 65.0,
                            width: 65.0,
                            child: Image(
                              image: AssetImage("assets/tab_saved.png"),
                              height: 21.0,
                              width: 13.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_snackBar);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  top: 24.0,
                                  bottom: 15.0,
                                  left: 9.0,
                                  right: 9.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0)),
                              height: 65.0,
                              width: 100.0,
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        CustomActionBar(
          hasAbackArrow: true,
          hasTitle: false,
          hasBg: false,
        ),
      ],
    ));
  }
}
