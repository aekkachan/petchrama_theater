import 'package:petchrama_theater/data/model/popular.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart' hide Headers;

part 'movies_rest_api.g.dart';

@RestApi(baseUrl: Apis.baseTMDBService)
abstract class MoviesRestApi {
  factory MoviesRestApi(Dio dio, {String baseUrl}) = _MoviesRestApi;

  @GET(Apis.baseTMDBService)
  @Headers({
    "Content-Type": "application/json",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZDM0YThhZGU1M2E5YjhiMTBlOTc4NTVkZTA5ODEyOCIsInN1YiI6IjYzMzFkZjUyNjdlMGY3MDA3ZWM4NzZhZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zHDKcacAzFZg7MHKXuxWafjIZcHrq1ZKugMBzU6iTBQ"
  })
  Future<Popular> getNowPlayingMovies(
    @Query("language") String language,
    @Query("page") String page,
  );

  @GET(Apis.baseTMDBService)
  Future<Popular> getPopularMovies(
    @Query("language") String language,
    @Query("page") String page,
  );

  @GET(Apis.baseTMDBService)
  Future<Popular> getTopRateMovies(
    @Query("language") String language,
    @Query("page") String page,
  );

  @GET(Apis.baseTMDBService)
  Future<Popular> getUpcomingMovies(
    @Query("language") String language,
    @Query("page") String page,
  );
}
