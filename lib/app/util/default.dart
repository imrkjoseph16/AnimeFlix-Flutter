class Default {

  static int DEFAULT_SELECTED_EPISODE = 1;
  static String DEFAULT_ANIME_EXPLORE = "Adventure";
}

enum QualityType {
  VERYHIGH("1080p"),
  HIGH("720p"),
  MEDIUM("480p"),
  LOW("360p");

  const QualityType(this.value);
  final String value;
}
