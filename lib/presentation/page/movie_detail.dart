import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petchrama_theater/presentation/widget/rating_bar.dart';
import 'package:petchrama_theater/utils/constants/genres.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';

class MovieDetail extends StatefulWidget {
  final imgTag; //
  final imgPath; //
  final title; //
  final content; //
  final voteAgerage; //
  final voteCount; //
  final releaseDate; //
  final orginalLanguage;
  final isAdult;
  final genreIds; //

  const MovieDetail(
      {super.key,
      this.imgTag,
      this.imgPath,
      this.title,
      this.content,
      this.voteAgerage,
      this.voteCount,
      this.releaseDate,
      this.orginalLanguage,
      this.isAdult,
      this.genreIds});

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
              background: Hero(
                tag: widget.imgTag,
                child: CachedNetworkImage(
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
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _utils.getWidth() * 0.01, top: _utils.getHeight() * 0.02, right: _utils.getWidth() * 0.03),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 30, letterSpacing: 0.5),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: _utils.getWidth() * 0.01, right: _utils.getWidth() * 0.03),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* rating star
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar(
                            voteAverage: widget.voteAgerage,
                          ),
                          SizedBox(
                            width: _utils.getWidth() * 0.03,
                          ),
                          Text(
                            '${widget.voteCount} votes',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, letterSpacing: 0.5),
                          )
                        ],
                      ),
                      //* release date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: _utils.getWidth() * 0.03,
                          ),
                          Text(
                            '${Utils.convertDate2String(widget.releaseDate, 'dd MMM yyyy')}',
                            style: TextStyle(fontSize: 15, letterSpacing: 0.5),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: _utils.getWidth() * 0.02,
                  ),
                  height: _utils.getHeight() * 0.1,
                  child: ListView.builder(
                    itemCount: widget.genreIds.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Chip(
                          elevation: 10,
                          backgroundColor: Colors.white70,
                          clipBehavior: Clip.antiAlias,
                          labelStyle: TextStyle(color: Colors.black87),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text(
                            Genres.ids['${widget.genreIds[index]}']!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(letterSpacing: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _utils.getWidth() * 0.03,
                      top: _utils.getHeight() * 0.03,
                      right: _utils.getWidth() * 0.03,
                      bottom: _utils.getHeight() * 0.03),
                  child: Text(
                    widget.content,
                    style: TextStyle(fontSize: 18, letterSpacing: 0.5),
                  ),
                ),
              ],
            )
          ]))
        ],
      )),
    );
  }
}
