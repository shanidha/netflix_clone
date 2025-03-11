import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/domain/core/api/api_calls.dart';
import 'package:netflix_clone/presentation/pages/search/widgets/search_idle.dart';
import 'package:netflix_clone/presentation/pages/search/widgets/search_result.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../domain/core/models/tile_card_model.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<Result>> searchResults = ValueNotifier([]);
  final ValueNotifier<List<Result>> idleMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> idleNameMovies = ValueNotifier([]);
  bool isLoading = false; 

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
    fetchPopularMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchTrendingMovies() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Result> movies = await fetchTrendingMoviesAPI();
      idleNameMovies.value = movies;
    } catch (e) {
      debugPrint("Error fetching trending movies: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// **Fetch Popular Movies**
  Future<void> fetchPopularMovies() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Result> movies = await fetchPopularMoviesAPI();
      idleMovies.value = movies;
    } catch (e) {
      debugPrint("Error fetching popular movies: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// **Fetch Search Results**
  Future<void> fetchSearchResults(String query) async {
    if (query.isEmpty) {
      searchResults.value = [];
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      List<Result> results = await fetchSearchResultsAPI(query);
      searchResults.value = results;
    } catch (e) {
      debugPrint("Error fetching search results: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Search Bar with Back Button**
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left,
                        color: kWhiteColor, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      onSuffixTap: () {
                        _searchController.clear();
                        fetchSearchResults("");
                      },
                      suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill,
                          color: Colors.grey),
                      placeholder: "Search games, shows, movies...",
                      prefixIcon:
                          const Icon(CupertinoIcons.search, color: Colors.grey),
                      onChanged: fetchSearchResults, 
                    ),
                  ),
                ],
              ),
              kHeight,

              /// **Loader when fetching**
              if (isLoading)
                const Center(
                    child: CircularProgressIndicator(color: Colors.red)),

              /// **Idle or Search Result Content**
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: searchResults,
                  builder: (context, List<Result> results, _) {
                    if (_searchController.text.isEmpty) {
                      return ValueListenableBuilder(
                        valueListenable: idleMovies,
                        builder: (context, List<Result> idleData, _) {
                          return SearchIdleWidget(
                            idleMovies: idleData,
                            idleNameMovies:
                                idleNameMovies.value, 
                          );
                        },
                      );
                    } else if (results.isEmpty) {
                      return const Center(
                        child: Text("No results found",
                            style: TextStyle(color: Colors.white)),
                      );
                    } else {
                      return SearchResultWidget(searchResults: results);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
