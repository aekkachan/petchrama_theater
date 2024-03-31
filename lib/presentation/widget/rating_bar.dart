import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final voteAverage;
  const RatingBar({super.key, this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: generatedStar(voteAverage),
    );
  }

  List<Widget> generatedStar(double score) {
    final List<Widget> starList = [];

    int fullStar = score ~/ 2; // diveder by 2 and convert double to int
    double halfStar = score - score.floor(); // if value more than of equal 5 show half star

    for (int i = 0; i < fullStar; i++) {
      starList.add(Icon(
        Icons.star_sharp,
        color: Colors.amber,
        size: 18,
      ));
    }

    if (halfStar <= 5)
      starList.add(Icon(
        Icons.star_half_sharp,
        color: Colors.amber,
        size: 18,
      ));

    return starList;
  }
}
