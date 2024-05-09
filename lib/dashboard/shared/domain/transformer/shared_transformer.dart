import 'package:anime_nation/dashboard/shared/data/dao/list_full_data.dart'
    as fulldata;
import 'package:anime_nation/dashboard/shared/data/dao/details_full_data.dart'
    as details_fulldata;
import 'package:anime_nation/dashboard/shared/presentation/video/data/dao/stream_full_data.dart'
    as stream_full_data;
import 'package:anime_nation/dashboard/shared/data/dto/anime/anime_response.dart'
    as a_response;
import 'package:anime_nation/dashboard/shared/data/dto/korean/korean_response.dart'
    as k_response;
import 'package:anime_nation/dashboard/shared/data/dto/movies/movies_response.dart'
    as m_response;
import 'package:anime_nation/dashboard/shared/data/dto/anime/anime_details_response.dart'
    as a_details_response;
import 'package:anime_nation/dashboard/shared/data/dto/korean/korean_details_response.dart'
    as k_details_response;
import 'package:anime_nation/dashboard/shared/data/dto/movies/movies_details_response.dart'
    as m_details_response;
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/anime_stream_response.dart'
    as a_stream_response;
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/korean_stream_response.dart'
    as k_stream_response;
import 'package:anime_nation/dashboard/shared/presentation/video/data/dto/movie_stream_response.dart'
    as m_stream_response;
import 'package:anime_nation/shared/data/video_watched_details.dart';

class SharedTransformer {
  // Continue Watching List //
  Stream<fulldata.ListFullData?> transformContinueWatchListResponse(
      Stream<List<VideoWatchedDetails>?> response) {
    return response.map((event) => fulldata.ListFullData(
        results: event
            ?.map((result) => fulldata.Results(
                id: result.id,
                title: fulldata.Title(english: result.name),
                image: result.image,
                duration: result.duration,
                totalDuration: result.totalDuration,
                watchedEpisode: result.watchedEpisode,
                itemType: result.itemType))
            .toList()));
  }

  // All Anime, Korean and Movies Lists //
  fulldata.ListFullData? transformAnimeListResponse(
      a_response.AnimeResponse? response) {
    return response != null
        ? fulldata.ListFullData(
            currentPage: response.currentPage,
            hasNextPage: response.hasNextPage,
            results: response.results
                ?.map((result) => fulldata.Results(
                    id: result.id,
                    title: fulldata.Title(
                      english: result.title?.english,
                      native: result.title?.native,
                      userPreferred: result.title?.userPreferred,
                    ),
                    image: result.image,
                    episodeTitle: result.episodeTitle,
                    trailer: fulldata.Trailer(
                      id: result.trailer?.id,
                      site: result.trailer?.site,
                      thumbnail: result.trailer?.thumbnail,
                    ),
                    description: result.description,
                    status: result.status,
                    rating: result.rating,
                    releaseDate: result.releaseDate.toString(),
                    color: result.color,
                    genres: result.genres,
                    totalEpisodes: result.totalEpisodes,
                    duration: result.duration,
                    type: result.type))
                .toList())
        : null;
  }

  fulldata.ListFullData? transformKoreanListResponse(
      k_response.KoreanResponse? response) {
    return response != null
        ? fulldata.ListFullData(
            currentPage: response.currentPage,
            hasNextPage: response.hasNextPage,
            results: response.results
                ?.map((result) => fulldata.Results(
                    id: result.id,
                    title: fulldata.Title(english: result.title),
                    image: result.image,
                    url: result.url))
                .toList())
        : null;
  }

  fulldata.ListFullData? transformMovieListResponse(
      m_response.MoviesResponse? response) {
    return response != null
        ? fulldata.ListFullData(
            currentPage: response.currentPage,
            hasNextPage: response.hasNextPage,
            totalResults: response.totalResults,
            totalPages: response.totalPages,
            results: response.results
                ?.map((result) => fulldata.Results(
                    id: result.id.toString(),
                    title: fulldata.Title(english: result.title),
                    image: result.image,
                    type: result.type,
                    rating: result.rating?.toInt(),
                    releaseDate: result.releaseDate))
                .toList())
        : null;
  }

  // All Anime, Korean and Movies details //
  details_fulldata.DetailsFullData? transformAnimeDetailsResponse(
      a_details_response.AnimeDetailsResponse? response) {
    return response != null
        ? details_fulldata.DetailsFullData(
            id: response.id,
            title: details_fulldata.Title(
                english: response.title?.english,
                native: response.title?.native,
                userPreferred: response.title?.userPreferred),
            synonyms: response.synonyms,
            isLicensed: response.isLicensed,
            isAdult: response.isAdult,
            countryOfOrigin: response.countryOfOrigin,
            trailer: details_fulldata.Trailer(
                id: response.trailer?.id,
                site: response.trailer?.site,
                thumbnail: response.trailer?.thumbnail),
            image: response.image,
            popularity: response.popularity,
            color: response.color,
            cover: response.cover,
            description: response.description,
            status: response.status,
            releaseDate: response.releaseDate.toString(),
            startDate: details_fulldata.StartDate(
                day: response.startDate?.day,
                month: response.startDate?.month,
                year: response.startDate?.year),
            endDate: details_fulldata.EndDate(
                day: response.endDate?.day,
                month: response.endDate?.month,
                year: response.endDate?.year),
            nextAiringEpisode: details_fulldata.NextAiringEpisode(
                airingTime: response.nextAiringEpisode?.airingTime,
                timeUntilAiring: response.nextAiringEpisode?.timeUntilAiring,
                episode: response.nextAiringEpisode?.episode),
            totalEpisodes: response.totalEpisodes,
            currentEpisode: response.currentEpisode,
            rating: response.rating,
            duration: response.duration,
            genres: response.genres,
            season: response.season,
            studios: response.studios,
            subOrDub: response.subOrDub,
            type: response.type,
            recommendations: response.recommendations
                ?.map((recommend) => details_fulldata.Recommendations(
                    id: recommend.id,
                    title: details_fulldata.Title(
                        english: recommend.title?.english,
                        native: recommend.title?.native,
                        userPreferred: recommend.title?.userPreferred),
                    episodes: recommend.episodes,
                    image: recommend.image,
                    cover: recommend.cover,
                    rating: recommend.rating,
                    type: recommend.type))
                .toList(),
            characters: response.characters
                ?.map((casts) => details_fulldata.Characters(
                    id: casts.id,
                    name: details_fulldata.Name(
                        first: casts.name?.first,
                        last: casts.name?.last,
                        full: casts.name?.full,
                        native: casts.name?.native,
                        userPreferred: casts.name?.userPreferred),
                    image: casts.image,
                    voiceActors: casts.voiceActors
                        ?.map((vActors) => details_fulldata.VoiceActors(
                            id: vActors.id,
                            language: vActors.language,
                            name:
                                details_fulldata.Name(first: casts.name?.first, last: casts.name?.last, full: casts.name?.full, native: casts.name?.native, userPreferred: casts.name?.userPreferred),
                            image: vActors.image))
                        .toList()))
                .toList(),
            relations: response.relations?.map((related) => details_fulldata.Relations(id: related.id, relationType: related.relationType, title: details_fulldata.Title(english: related.title?.english, native: related.title?.native, userPreferred: related.title?.userPreferred), status: related.status, episodes: related.episodes, image: related.image, color: related.color, type: related.type, cover: related.cover, rating: related.rating)).toList(),
            artwork: response.artwork?.map((art) => details_fulldata.Artwork(img: art.img, type: art.type, providerId: art.providerId)).toList(),
            episodes: response.episodes?.map((episode) => details_fulldata.Episodes(id: episode.id, title: episode.title, description: episode.description, number: episode.number, image: episode.image, airDate: episode.airDate)).toList())
        : null;
  }

  details_fulldata.DetailsFullData? transformKoreanDetailsResponse(
      k_details_response.KoreanDetailsResponse? response) {
    return response != null
        ? details_fulldata.DetailsFullData(
            id: response.id,
            title: details_fulldata.Title(english: response.title),
            image: response.image,
            description: response.description,
            genres: response.genres,
            releaseDate: response.releaseDate,
            otherNames: response.otherNames,
            episodes: response.episodes
                ?.map((episode) => details_fulldata.Episodes(
                    id: episode.id,
                    title: episode.title,
                    url: episode.url,
                    airDate: episode.releaseDate,
                    type: episode.subType,
                    number: episode.episode))
                .toList())
        : null;
  }

  details_fulldata.DetailsFullData? transformMovieDetailsResponse(
      m_details_response.MoviesDetailsResponse? response) {
    return response != null
        ? details_fulldata.DetailsFullData(
            id: response.id,
            title: details_fulldata.Title(english: response.title),
            trailer: details_fulldata.Trailer(
                id: response.trailer?.id,
                site: response.trailer?.site,
                thumbnail: response.trailer?.url),
            image: response.image,
            cover: response.cover,
            description: response.description,
            releaseDate: response.releaseDate,
            rating: response.rating,
            duration: response.duration,
            genres: response.genres,
            type: response.type,
            totalEpisodes: response.totalEpisodes,
            totalSeasons: response.totalSeasons,
            translations: response.translations
                ?.map((translation) => details_fulldata.Translations(
                    description: translation.description,
                    title: translation.title,
                    language: translation.language))
                .toList(),
            logos: response.logos
                ?.map((logo) => details_fulldata.Logos(
                    url: logo.url,
                    aspectRatio: logo.aspectRatio,
                    width: logo.width))
                .toList(),
            recommendations: response.recommendations
                ?.map((recommend) => details_fulldata.Recommendations(
                    id: recommend.id,
                    title: details_fulldata.Title(english: recommend.title),
                    image: recommend.image,
                    type: recommend.type,
                    rating: recommend.rating,
                    releaseDate: recommend.releaseDate))
                .toList(),
            writers: response.writers,
            directors: response.directors,
            characters: response.actors
                ?.map((casts) => details_fulldata.Characters(
                    name: details_fulldata.Name(first: casts)))
                .toList(),
            relations: response.similar
                ?.map((related) => details_fulldata.Relations(
                    id: related.id,
                    title: details_fulldata.Title(english: related.title),
                    image: related.image,
                    type: related.type,
                    releaseDate: related.releaseDate,
                    rating: related.rating))
                .toList(),
            seasons: response.seasons
                ?.map((season) => details_fulldata.Seasons(
                    season: season.season,
                    isReleased: season.isReleased,
                    episodes: season.episodes
                        ?.map((episode) =>
                            details_fulldata.Episodes(id: episode.id, title: episode.title, episode: episode.episode, season: episode.season, airDate: episode.releaseDate, description: episode.description, url: episode.url, img: details_fulldata.Image(mobile: episode.img?.mobile, hd: episode.img?.hd)))
                        .toList(),
                    image: details_fulldata.Image(mobile: season.image?.mobile, hd: season.image?.hd)))
                .toList())
        : null;
  }

  // All Anime, Korean and Movies Streaming link //
  stream_full_data.StreamFullData? transformAnimeStreamResponse(
      a_stream_response.AnimeStreamResponse? response) {
    return response != null
        ? stream_full_data.StreamFullData(
            headers:
                stream_full_data.Headers(referer: response.headers?.referer),
            sources: response.sources
                ?.map((source) => stream_full_data.Sources(
                    url: source.url,
                    quality: source.quality,
                    isM3U8: source.isM3U8))
                .toList(),
            download: response.download)
        : null;
  }

  stream_full_data.StreamFullData? transformKoreanStreamResponse(
      k_stream_response.KoreanStreamResponse? response) {
    return response != null
        ? stream_full_data.StreamFullData(
            headers: stream_full_data.Headers(),
            sources: response.sources
                ?.map((source) => stream_full_data.Sources(
                    url: source.url, isM3U8: source.isM3U8))
                .toList(),
            subtitles: response.subtitles
                ?.map((sub) =>
                    stream_full_data.Subtitles(url: sub.url, lang: sub.lang))
                .toList())
        : null;
  }

  stream_full_data.StreamFullData? transformMovieStreamResponse(
      m_stream_response.MovieStreamResponse? response) {
    return response != null
        ? stream_full_data.StreamFullData(
            headers: stream_full_data.Headers(),
            sources: [stream_full_data.Sources(url: response.data?.file)],
            subtitles: response.data?.sub
                ?.map((sub) =>
                    stream_full_data.Subtitles(url: sub.file, lang: sub.lang))
                .toList())
        : null;
  }
}
