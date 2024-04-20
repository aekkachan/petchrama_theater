import 'package:petchrama_theater/data/datasources/remote/movies_rest_api.dart';
import 'package:petchrama_theater/data/model/credits.dart';
import 'package:petchrama_theater/data/model/now_playing.dart';
import 'package:petchrama_theater/data/model/popular.dart';
import 'package:petchrama_theater/data/model/top_rate.dart';
import 'package:petchrama_theater/data/model/upcoming.dart';
import 'package:petchrama_theater/utils/resource/dio_configuration.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<NowPlaying?> nowPlayingMovies(NowPlayingMoviesRef ref) async {
  try {
    NowPlaying data = await MoviesRestApi(DioConfiguration.getInstance()).getNowPlayingMovies('en-US', '1');
    print(data.results![0].originalTitle);
    return data;
  } catch (error) {
    return NowPlaying();
  }
}

@riverpod
Future<Popular?> popularMovies(PopularMoviesRef ref) async {
  try {
    Popular data = await MoviesRestApi(DioConfiguration.getInstance()).getPopularMovies('en-US', '1');
    print(data.results![0].originalTitle);
    return data;
  } catch (error) {
    return Popular();
  }
}

@riverpod
Future<TopRate?> topRateMovies(TopRateMoviesRef ref) async {
  try {
    TopRate data = await MoviesRestApi(DioConfiguration.getInstance()).getTopRateMovies('en-US', '1');
    print(data.results![0].originalTitle);
    return data;
  } catch (error) {
    return TopRate();
  }
}

@riverpod
Future<Upcoming?> upcomingMovies(UpcomingMoviesRef ref) async {
  try {
    Upcoming data = await MoviesRestApi(DioConfiguration.getInstance()).getUpcomingMovies('en-US', '1');
    print(data.results![0].originalTitle);
    return data;
  } catch (error) {
    return Upcoming();
  }
}

@riverpod
Future<Credits?> creditMovies(CreditMoviesRef ref) async {
  try {
    Credits data = await MoviesRestApi(DioConfiguration.getInstance()).getCredits('en-US', '693134');
    print(data.cast![0].character);
    print(data.cast![0].name);
    return data;
  } catch (error) {
    return Credits();
  }
}
