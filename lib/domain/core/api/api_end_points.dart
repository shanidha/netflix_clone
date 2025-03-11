import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloadDBApi = "trending/all/day?api_key=$apiKey";
  static const downloadMockApi =
      "$baseUrlMockApi/c41c919c-01c6-4480-b371-eaa0432361f2";
  static const netflixMockApi =
      "$baseUrlMockApi/f1858997-9783-494f-b8cb-33ad2b9c3d52";
  static const trendingApiEndPoint = "trending/movie/day";
  static const trendingWeekApiEndPoint = "trending/movie/week";
  static const topRatedApiEndPoint = 'movie/top_rated';
  static const popularApiEndPoint = 'movie/popular';
  static const upcomingApiEndPoint = 'movie/upcoming';
  static const nowPlayingApiEndPoint = 'movie/now_playing';
  static const topShowsApiEndPoint = 'tv/top_rated';
  static const upcomingNewHotApiEndPoint = "movie/upcoming";
  static const searchAPI = "search/movie";
}
