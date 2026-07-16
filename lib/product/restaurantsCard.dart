import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/ratingBar.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/restaurantCardImage.dart';

class RestaurantsCard extends StatefulWidget {
  const RestaurantsCard({super.key,required this.path,
    required this.restaurantName,
    required this.rating});

  final String path;
  final String restaurantName;
  final String rating;

  @override
  State<RestaurantsCard> createState() => _RestaurantsCardState();
}

class _RestaurantsCardState extends State<RestaurantsCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.3,
      width: 300,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorConstants.instance.titleColor),
        ),
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: RestaurantImage(folderPath: widget.path)),
            Positioned(
                bottom: 40,
                left: 20,
                child:
                Text(widget.restaurantName, style: TextFonts.instance.imageFront)),
            Positioned(bottom: 10, right: 20, child: RatingBar(rating: widget.rating))
          ],
        ),
      ),
    );
  }
}