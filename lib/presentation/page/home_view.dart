import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petchrama_theater/domain/provider.dart';
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
    final popularMovies = ref.read(popularMoviesProvider);

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: _utils.getHeight() / 2.3,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Movies Name'),
              background: Image.network(
                "https://fastly.picsum.photos/id/63/5000/2813.jpg?hmac=HvaeSK6WT-G9bYF_CyB2m1ARQirL8UMnygdU9W6PDvM",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              popularMovies.when(
                  data: (data) => Text(data.results![0].id.toString()),
                  error: (error, StackTrace) => Text('Error: $error'),
                  loading: () => CircularProgressIndicator()),
              // _nowPlayingMovies(),
              // _popularMovies(),
              // _topRateMovies(),
              // _upComingMovies(),
            ]),
          ),
        ],
      )),
    );
  }

  Widget _nowPlayingMovies() {
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
          Stack(
            children: [
              Container(
                height: _utils.getHeight() * 0.28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        margin: EdgeInsets.only(right: _utils.getWidth() * 0.02),
                        width: _utils.getWidth() * 0.40,
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: EdgeInsets.only(left: 3, top: 3, right: 5, bottom: 3),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate,
                                color: Colors.amber,
                                size: 15,
                              ),
                              Text(
                                '9.5',
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
            ],
          )
        ],
      ),
    );
  }

  Widget _popularMovies() {
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

  Widget _topRateMovies() {
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
