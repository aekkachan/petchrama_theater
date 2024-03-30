import 'package:petchrama_theater/data/datasources/remote/movies_rest_api.dart';
import 'package:petchrama_theater/data/model/popular.dart';
import 'package:petchrama_theater/utils/resource/dio_configuration.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<Popular> popularMovies(PopularMoviesRef ref) async {
  print('000000000');
  Popular? response;
  MoviesRestApi(DioConfiguration.getInstance())
      .getPopularMovies(
    'en-US',
    '1',
  )
      .then((value) {
    response = value;
    print('11111111');
  }).onError((error, stackTrace) {
    print(error.toString());
    print(stackTrace.toString());
    response = Popular();
    print('222222222');
  });
  print('33333333');
  return response!;
}
