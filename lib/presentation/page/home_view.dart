import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petchrama_theater/data/model/now_playing.dart' as _nowPlaying;
import 'package:petchrama_theater/data/model/popular.dart' as _popular;
import 'package:petchrama_theater/data/model/top_rate.dart' as _topRate;
import 'package:petchrama_theater/domain/provider.dart';
import 'package:petchrama_theater/presentation/page/movie_detail.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:petchrama_theater/utils/resource/utils.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  // @override
  // State<HomeView> createState() => _HomeViewState();

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

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: _utils.getHeight() * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Movies Name'),
              background: Image.network(
                "https://fastly.picsum.photos/id/63/5000/2813.jpg?hmac=HvaeSK6WT-G9bYF_CyB2m1ARQirL8UMnygdU9W6PDvM",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                nowPlayingMovies.when(
                  data: (data) => _nowPlayingMoviesWidget(data!.results!),
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

  Widget _nowPlayingMoviesWidget(List<_nowPlaying.Result> result) {
    return Container(
      margin: EdgeInsets.only(left: _utils.getWidth() * 0.03, top: _utils.getHeight() * 0.03, right: _utils.getWidth() * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Now Playing',
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
            height: _utils.getHeight() * 0.28,
            child: ListView.builder(
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
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 400),
                              pageBuilder: (context, animation, secondaryAnimation) => MovieDetail(
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
                        tag: 'movie_poster$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: _utils.getWidth() * 0.40,
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

  Widget _popularMovies(List<_popular.Result> result) {
    return Container(
      margin: EdgeInsets.only(left: _utils.getWidth() * 0.03, top: _utils.getHeight() * 0.03, right: _utils.getWidth() * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Popular',
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
            height: _utils.getHeight() * 0.30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      margin: EdgeInsets.only(right: 5),
                      width: _utils.getWidth() * 0.40,
                    )),
          ),
        ],
      ),
    );
  }

  Widget _topRateMovies(List<_topRate.Result> result) {
    return Container(
      margin: EdgeInsets.only(left: _utils.getWidth() * 0.03, top: _utils.getHeight() * 0.03, right: _utils.getWidth() * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Top Rate',
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
            height: _utils.getHeight() * 0.30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      margin: EdgeInsets.only(right: 5),
                      width: _utils.getWidth() * 0.40,
                    )),
          ),
        ],
      ),
    );
  }

  Widget _upComingMovies() {
    return Container(
      margin: EdgeInsets.only(left: _utils.getWidth() * 0.03, top: _utils.getHeight() * 0.03, right: _utils.getWidth() * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upcoming',
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
            height: _utils.getHeight() * 0.30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      margin: EdgeInsets.only(right: 5),
                      width: _utils.getWidth() * 0.40,
                    )),
          ),
        ],
      ),
    );
  }
}
