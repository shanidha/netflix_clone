//Get Download API Calls

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/strings.dart';

import 'package:netflix_clone/domain/core/models/download_model.dart';
import 'package:netflix_clone/domain/core/models/netflix_model.dart';

import '../../../infrastructure/api_key.dart';
import '../models/tile_card_model.dart';
import 'api_end_points.dart';

//Load Download Datas
Future<DownloadsData?> getDownloadsData() async {
  try {
    var response = await Dio().get(ApiEndPoints.downloadMockApi);
    if (response.statusCode == 200) {
      debugPrint(response.data.toString());
      if (response.data is Map<String, dynamic>) {
        return DownloadsData.fromJson(response.data);
      } else {
        debugPrint("Error: Unexpected response format");
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

//Load Netflix Datas
Future<NetflixModel?> getNetflixData() async {
  try {
    var response = await Dio().get(ApiEndPoints.netflixMockApi);
    if (response.statusCode == 200) {
      debugPrint(response.data.toString());
      if (response.data is Map<String, dynamic>) {
        return NetflixModel.fromJson(response.data);
      } else {
        debugPrint("Error: Unexpected response format");
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

/// **Fetch Home Data Based on Category**
Future<List<Result>> fetchHomeData(String endpoint) async {
  try {
    var response = await Dio().get(
      '$baseUrldb/$endpoint',
      queryParameters: {"api_key": apiKey},
    );

    if (response.statusCode == 200) {
      TileCardModel data = tileCardModelFromJson(response.toString());
      return data.results;
    }
  } catch (e) {
    debugPrint("Error fetching $endpoint data: $e");
  }
  return [];
}
 /// **Fetch Coming Soon Movies (Upcoming)**
  Future<List<Result>> fetchComingSoon() async {
    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.upcomingNewHotApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching Coming Soon data: $e");
    }
    return [];
  }

  /// **Fetch Everyone's Watching Movies (Popular)**
  Future<List<Result>> fetchEveryonesWatching() async {
    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.popularApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching Everyone's Watching data: $e");
    }
    return [];
  }
    /// **Fetch Trending & Popular Movies for Idle State**
  Future<List<Result>> fetchSearchIdleMovies() async {
    try {
      // Fetch Trending Movies
      var response1 = await Dio().get(
        '$baseUrldb/${ApiEndPoints.trendingWeekApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      // Fetch Popular Movies
      var response2 = await Dio().get(
        '$baseUrldb/${ApiEndPoints.popularApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      List<Result> trendingMovies = [];
      List<Result> popularMovies = [];

      if (response1.statusCode == 200) {
        TileCardModel data1 = tileCardModelFromJson(response1.toString());
        trendingMovies = data1.results;
      }

      if (response2.statusCode == 200) {
        TileCardModel data2 = tileCardModelFromJson(response2.toString());
        popularMovies = data2.results;
      }

      return [...trendingMovies, ...popularMovies];
    } catch (e) {
      debugPrint("Error fetching idle movies: $e");
      return [];
    }
  }

  /// **Fetch Search Results**
  Future<List<Result>> fetchSearchResultsList(String query) async {
    if (query.isEmpty) return [];

    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.searchAPI}',
        queryParameters: {"query": query, "api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching search results: $e");
    }
    return [];
  }
   /// **Fetch Trending Movies**
  Future<List<Result>> fetchTrendingMoviesAPI() async {
    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.trendingWeekApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching trending movies: $e");
    }
    return [];
  }

  /// **Fetch Popular Movies**
  Future<List<Result>> fetchPopularMoviesAPI() async {
    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.popularApiEndPoint}',
        queryParameters: {"api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching popular movies: $e");
    }
    return [];
  }

  /// **Fetch Search Results**
  Future<List<Result>> fetchSearchResultsAPI(String query) async {
    if (query.isEmpty) return [];

    try {
      var response = await Dio().get(
        '$baseUrldb/${ApiEndPoints.searchAPI}',
        queryParameters: {"query": query, "api_key": apiKey},
      );

      if (response.statusCode == 200) {
        TileCardModel data = tileCardModelFromJson(response.toString());
        return data.results;
      }
    } catch (e) {
      debugPrint("Error fetching search results: $e");
    }
    return [];
  }