class Apis {
  static const String token =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZDM0YThhZGU1M2E5YjhiMTBlOTc4NTVkZTA5ODEyOCIsInN1YiI6IjYzMzFkZjUyNjdlMGY3MDA3ZWM4NzZhZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zHDKcacAzFZg7MHKXuxWafjIZcHrq1ZKugMBzU6iTBQ';

  static const String baseTMDBMovieListService = 'https://api.themoviedb.org/3/movie';
  static const String baseTMDBSearchService = 'https://api.themoviedb.org/3/search';
  static const String baseTMDBimg = 'https://image.tmdb.org/t/p/w500';

  // TMDB MOVIES LIST SERVICE
  static const String nowPlaying = '/now_playing';
  static const String popular = '/popular';
  static const String topRated = '/top_rated';
  static const String upcoming = '/upcoming';

  // TMDB SEARCH SERVICE
  static const String movie = '/movie';
}
