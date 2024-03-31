import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';

class MovieDetail extends StatefulWidget {
  final imgPath;
  final title;
  final content;
  final voteAgerage;
  final voteCount;
  final releaseDate;
  final orginalLanguage;
  final isAdule;

  const MovieDetail(
      {super.key,
      this.imgPath,
      this.title,
      this.content,
      this.voteAgerage,
      this.voteCount,
      this.releaseDate,
      this.orginalLanguage,
      this.isAdule});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late Utils _utils;

  @override
  void initState() {
    super.initState();
    _utils = Utils(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: _utils.getHeight() * 0.6,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.imgPath,
                progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('rating bar'),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 25),
                ),
                Text('data'),
                Text(widget.content),
              ],
            )
          ]))
        ],
      )),
    );
  }
}
