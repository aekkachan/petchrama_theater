import 'package:dio/dio.dart';
import 'package:petchrama_theater/data/model/now_playing.dart';
import 'package:petchrama_theater/data/model/popular.dart';
import 'package:petchrama_theater/data/model/top_rate.dart';
import 'package:petchrama_theater/data/model/upcoming.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_rest_api.g.dart';

@RestApi(baseUrl: Apis.baseTMDBMovieListService)
abstract class MoviesRestApi {
  factory MoviesRestApi(Dio dio, {String baseUrl}) = _MoviesRestApi;

  @GET(Apis.nowPlaying)
  Future<NowPlaying> getNowPlayingMovies(
    @Query("language") String language,
    @Query("page") int page,
  );

  @GET(Apis.popular)
  Future<Popular> getPopularMovies(
    @Query("language") String language,
    @Query("page") String page,
  );

  @GET(Apis.topRated)
  Future<TopRate> getTopRateMovies(
    @Query("language") String language,
    @Query("page") String page,
  );

  @GET(Apis.upcoming)
  Future<Upcoming> getUpcomingMovies(
    @Query("language") String language,
    @Query("page") String page,
  );
}
