import 'package:e_comm_app/constants.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard(
      {this.onPressed, this.imageUrl, this.title, this.price, this.productId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 390.0,
          margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Stack(
            children: [
              Container(
                height: 390.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      "$imageUrl",
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Constants.fontsize,
                      ),
                      Text(
                        " $price" ?? "Price",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
