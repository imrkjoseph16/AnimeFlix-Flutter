class Default {

  static int DEFAULT_SELECTED_EPISODE = 1;
  static String DEFAULT_ANIME_EXPLORE = "Adventure";
  static String ANIME_BASE_URL = "https://anime-nation-server.vercel.app/meta/anilist/";
  static String KOREAN_BASE_URL = "https://anime-nation-server.vercel.app/movies/dramacool/";
  static String MOVIES_BASE_URL = "https://anime-nation-server.vercel.app/meta/tmdb/";
  static String MOVIE_STREAM_ALTERNATIVE_BASE_URL = "https://api-movie-source.vercel.app/";

  static String DEFAULT_KOREAN_SERVER = "asianload";
  static String DEFAULT_USERS_DB = "users";
  static String DEFAULT_UNFINISH_WATCH_DB = "unfinish_watching";
}

enum QualityType {
  VERYHIGH("1080p"),
  HIGH("720p"),
  MEDIUM("480p"),
  LOW("360p");

  const QualityType(this.value);
  final String value;
}
