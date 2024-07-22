import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petchrama_theater/domain/provider.dart';
import 'package:petchrama_theater/presentation/page/movie_detail.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';
import 'dart:math' as math;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late Utils _utils;

  @override
  void initState() {
    super.initState();
    _utils = Utils(context);
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverAppBarDelegate(
              minHeight: 0,
              maxHeight: _utils.getHeight() * 0.6,
              child: Container(
                alignment: Alignment.center,
                child: popularMovies.when(
                  data: (data) => CustomCarouselPageView.images(context, data!.results!),
                  error: (error, StackTrace) => Text('Error: $error'),
                  loading: () => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // * now playing scetion
                nowPlayingMovies.when(
                  data: (data) => _moviesList('Now Playing', data!.results!),
                  error: (error, StackTrace) => Text('Error: $error'),
                  loading: () => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),

                // * upcoming scetion
                upcomingMovies.when(
                  data: (data) => _moviesList('Upcoming', data!.results!, isRevert: true),
                  error: (error, StackTrace) => Text('Error: $error'),
                  loading: () => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),

                // * popular sction
                popularMovies.when(
                  data: (data) => _moviesList('Popular', data!.results!, isRevert: true),
                  error: (error, StackTrace) => Text('Error: $error'),
                  loading: () => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _moviesList(String title, List<dynamic> result, {bool isRevert = false}) {
    return Container(
      margin: EdgeInsets.only(
          left: _utils.getWidth() * 0.03, top: _utils.getHeight() * 0.03, right: _utils.getWidth() * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'see all',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: _utils.getHeight() * 0.02,
          ),
          Container(
            height: _utils.getHeight() * 0.20,
            child: ListView.builder(
              reverse: isRevert,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: result.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                    imgTag: 'movie_poster$index',
                                    imgPath: '${Apis.baseTMDBimg}${result[index].posterPath}',
                                    backdropPath: '${Apis.baseTMDBimg}${result[index].backdropPath}',
                                    title: result[index].title,
                                    content: result[index].overview,
                                    voteAgerage: result[index].voteAverage,
                                    voteCount: result[index].voteCount,
                                    releaseDate: result[index].releaseDate,
                                    orginalLanguage: result[index].originalLanguage,
                                    isAdult: result[index].adult,
                                    genreIds: result[index].genreIds,
                                  )),
                        );
                      },
                      child: Hero(
                        tag: '${title}movie_poster$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: _utils.getWidth() * 0.27,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              placeholderFadeInDuration: Duration(milliseconds: 500),
                              imageUrl: '${Apis.baseTMDBimg}${result[index].posterPath}',
                              progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.only(left: 3, top: 3, right: 5, bottom: 3),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.red.shade600),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rate,
                              color: Colors.amber,
                              size: 14,
                            ),
                            Text(
                              result[index].voteAverage!.toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class CustomCarouselPageView extends StatefulWidget {
  const CustomCarouselPageView({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  factory CustomCarouselPageView.images(BuildContext context, List<dynamic> result) => CustomCarouselPageView(
        children: [
          for (final data in result)
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: '${Apis.baseTMDBimg}${data.posterPath}',
                      placeholderFadeInDuration: Duration(milliseconds: 500),
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Movies Name',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'Action / Crime / Drama',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                  ),
                )
              ],
            )
        ],
      );

  @override
  State createState() => _CustomCarouselPageViewState();
}

double viewportFraction = 0.75;

class _CustomCarouselPageViewState extends State<CustomCarouselPageView> {
  final pageController = PageController(viewportFraction: viewportFraction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxWidth = constraint.maxWidth;
        return PageView.builder(
          allowImplicitScrolling: true,
          controller: pageController,
          itemCount: widget.children.length,
          itemBuilder: (_, index) {
            final child = widget.children[index];
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, _) {
                final ratioX = pageController.offset / maxWidth / viewportFraction - index;

                return Transform.rotate(
                  angle: math.pi * -0.05 * ratioX,
                  child: Transform.translate(
                    offset: Offset(ratioX * 20, ratioX.abs() * 30),
                    child: Transform.scale(
                      scale: 0.85,
                      child: child,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
