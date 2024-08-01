import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petchrama_theater/domain/provider.dart';
import 'package:petchrama_theater/presentation/page/all_movies_view.dart';
import 'package:petchrama_theater/presentation/page/movie_detail.dart';
import 'package:petchrama_theater/presentation/widget/custom_carousel_page_view.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:petchrama_theater/utils/constants/genres.dart';
import 'package:petchrama_theater/utils/extension/space_rxtension.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';

import 'package:shimmer/shimmer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late Utils _utils;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _utils = Utils(context);
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider(1));
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 43, 43, 53),
                Color.fromARGB(255, 22, 21, 31),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      'Popular Movies',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    floating: false,
                    forceMaterialTransparency: true,
                    // snap: true,
                    // stretch: true,
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      minHeight: 0,
                      maxHeight: _utils.getHeight() * 0.6,
                      child: Container(
                        alignment: Alignment.center,
                        child: popularMovies.when(
                          data: (data) => CustomCarouselPageView.images(context, data!.results!),
                          error: (error, StackTrace) => Text('Error: $error'),
                          loading: () => Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: _utils.getWidth() * 0.5,
                              height: _utils.getHeight() * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
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
                          loading: () => SizedBox(),
                        ),
                        // * upcoming scetion
                        upcomingMovies.when(
                          data: (data) => _moviesList('Upcoming', data!.results!, isRevert: true),
                          error: (error, StackTrace) => Text('Error: $error'),
                          loading: () => SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 42, 41, 51),
        iconSize: 25,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          applyTextScaling: true,
        ),
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey.shade600,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '•',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _moviesList(String title, List<dynamic> result, {bool isRevert = false}) => Container(
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllMoviesView(),
                        ));
                  },
                  child: Text(
                    'see all',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                ),
              ],
            ),
            (_utils.getHeight() * 0.02).kH,
            Container(
              height: _utils.getHeight() * 0.35,
              child: ListView.builder(
                reverse: isRevert,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, index) => Container(
                  width: _utils.getWidth() * 0.40,
                  margin: EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(
                                          imgTag: '${title}movie_poster$index',
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
                              child: Container(
                                width: _utils.getWidth() * 0.35,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  placeholderFadeInDuration: Duration(milliseconds: 500),
                                  imageUrl: '${Apis.baseTMDBimg}${result[index].posterPath}',
                                  progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                                    alignment: Alignment.center,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade400,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: _utils.getWidth() * 0.34,
                                        height: _utils.getHeight() * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          // rating star
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.only(left: 3, top: 3, right: 5, bottom: 3),
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.red.shade600),
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
                      Text(
                        result[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        title.trim().toUpperCase() == 'UPCOMING'
                            ? '${Utils.convertDate2String(result[index].releaseDate, 'dd MMMM yyyy')}'
                            : getGenre(result[index].genreIds),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  String getGenre(List<int> genreIds) {
    String genre = '';

    for (int i = 0; i < genreIds.length; i++) {
      genre += Genres.ids[genreIds[i].toString()]!;
      if (i < genreIds.length - 1) genre += ' / ';
    }
    return genre;
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
