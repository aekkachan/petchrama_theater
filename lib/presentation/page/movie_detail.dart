import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petchrama_theater/domain/provider.dart';
import 'package:petchrama_theater/presentation/widget/rating_bar.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:petchrama_theater/utils/constants/genres.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetail extends ConsumerStatefulWidget {
  final id;
  final imgTag;
  final imgPath;
  final backdropPath;
  final title;
  final content;
  final voteAgerage;
  final voteCount;
  final releaseDate;
  final orginalLanguage;
  final isAdult;
  final genreIds;

  const MovieDetail(
      {super.key,
      this.id,
      this.imgTag,
      this.imgPath,
      this.backdropPath,
      this.title,
      this.content,
      this.voteAgerage,
      this.voteCount,
      this.releaseDate,
      this.orginalLanguage,
      this.isAdult,
      this.genreIds});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  late Utils _utils;

  @override
  void initState() {
    super.initState();
    _utils = Utils(context);
  }

  @override
  Widget build(BuildContext context) {
    final creditMovies = ref.watch(creditMoviesProvider(widget.id));

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            expandedHeight: _utils.getHeight() * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                        ).createShader(bounds);
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(seconds: 1),
                        imageUrl: widget.backdropPath,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 25.0, // Example font size
                          color: Colors.white, // Example text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: _utils.getWidth() * 0.02, right: _utils.getWidth() * 0.02),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* rating star
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
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
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: _utils.getHeight() * 0.02,
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
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _utils.getHeight() * 0.01,
                                ),
                                // * language
                                Row(
                                  children: [
                                    Icon(
                                      Icons.language_sharp,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: _utils.getWidth() * 0.03,
                                    ),
                                    Text(
                                      widget.orginalLanguage,
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _utils.getHeight() * 0.01,
                                ),
                                // * adult content
                                Row(
                                  children: [
                                    Icon(
                                      Icons.no_adult_content_sharp,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: _utils.getWidth() * 0.03,
                                    ),
                                    Text(
                                      widget.isAdult ? 'Not for kids' : 'No adult content',
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Hero(
                              tag: widget.imgTag,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  fadeInDuration: Duration(seconds: 1),
                                  width: _utils.getWidth() * 0.30,
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
                              labelPadding: EdgeInsets.only(left: _utils.getWidth() * 0.04, right: _utils.getWidth() * 0.04),
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.white70,
                              clipBehavior: Clip.antiAlias,
                              labelStyle: TextStyle(color: Colors.black87),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                Genres.ids['${widget.genreIds[index]}']!,
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
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: _utils.getWidth() * 0.02, right: _utils.getWidth() * 0.02),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cast',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    creditMovies.when(
                      data: (data) => Padding(
                        padding: EdgeInsets.only(
                            left: _utils.getWidth() * 0.02, right: _utils.getWidth() * 0.02, bottom: _utils.getHeight() * 0.02),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _castImg('${Apis.baseTMDBimg200}${data!.cast![0].profilePath}'),
                            _castImg('${Apis.baseTMDBimg200}${data.cast![1].profilePath}'),
                            _castImg('${Apis.baseTMDBimg200}${data.cast![2].profilePath}'),
                            _castImg('${Apis.baseTMDBimg200}${data.cast![3].profilePath}'),
                          ],
                        ),
                      ),
                      error: (error, stackTrace) => Text('ERROR'),
                      loading: () => SizedBox.shrink(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _castImg(String imgPath) {
    return Container(
      width: _utils.getWidth() * 0.24,
      height: 120,
      alignment: Alignment.center,
      child: CachedNetworkImage(
        fadeInDuration: Duration(seconds: 1),
        imageUrl: imgPath,
        fit: BoxFit.cover,
        width: _utils.getWidth() * 0.2,
      ),
    );
  }
}
