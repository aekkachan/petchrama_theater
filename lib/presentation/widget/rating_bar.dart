import 'package:flutter/material.dart';

class Ratingbar extends StatelessWidget {
  final voteAverage;
  const Ratingbar({super.key, this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: generatedStar(voteAverage),
    );
  }

  List<Widget> generatedStar(String score) {
    final List<Widget> starList = [];

    return starList;
  }
}
