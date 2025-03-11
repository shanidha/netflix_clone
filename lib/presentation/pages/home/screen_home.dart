
import 'package:flutter/material.dart';
import 'package:netflix_clone/domain/core/api/api_end_points.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../domain/core/api/api_calls.dart';
import '../../../domain/core/models/tile_card_model.dart';
import '../search/screen_search.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/main_title_card.dart';
import 'widgets/number_title_card.dart';
import 'widgets/background_card.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final ValueNotifier<List<Result>> trendingMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> topRatedMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> popularMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> upcomingMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> nowPlayingMovies = ValueNotifier([]);
  final ValueNotifier<List<Result>> top10TvShows = ValueNotifier([]);

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// **Fetch Data Using API Service**
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      trendingMovies.value =
          await fetchHomeData(ApiEndPoints.trendingApiEndPoint);
      topRatedMovies.value =
          await fetchHomeData(ApiEndPoints.topRatedApiEndPoint);
      popularMovies.value =
          await fetchHomeData(ApiEndPoints.popularApiEndPoint);
      upcomingMovies.value =
          await fetchHomeData(ApiEndPoints.upcomingApiEndPoint);
      nowPlayingMovies.value =
          await fetchHomeData(ApiEndPoints.nowPlayingApiEndPoint);
      top10TvShows.value =
          await fetchHomeData(ApiEndPoints.topShowsApiEndPoint);
    } catch (e) {
      debugPrint("Error fetching home data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScreenSearch()),
              );
            },
            title: "For Adam",
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.red))
            : ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("TV Shows", style: kHomeTitleTest),
                      Text("Movies", style: kHomeTitleTest),
                      Text("Categories", style: kHomeTitleTest),
                    ],
                  ),
                  const BackGroundCardWidget(),
                  ValueListenableBuilder(
                    valueListenable: trendingMovies,
                    builder: (context, List<Result> movies, _) {
                      return MainCardTitleData(
                          title: "Trending Now", imageUrl: movies);
                    },
                  ),
                  kHeight,
                  ValueListenableBuilder(
                    valueListenable: nowPlayingMovies,
                    builder: (context, List<Result> movies, _) {
                      return MainCardTitleData(
                          title: "Now Playing", imageUrl: movies);
                    },
                  ),
                  kHeight,
                  ValueListenableBuilder(
                    valueListenable: top10TvShows,
                    builder: (context, List<Result> tvShows, _) {
                      return NumberTitleCard(tvShows: tvShows);
                    },
                  ),
                  kHeight,
                  ValueListenableBuilder(
                    valueListenable: topRatedMovies,
                    builder: (context, List<Result> movies, _) {
                      return MainCardTitleData(
                          title: "Top Rated", imageUrl: movies);
                    },
                  ),
                  kHeight,
                  ValueListenableBuilder(
                    valueListenable: upcomingMovies,
                    builder: (context, List<Result> movies, _) {
                      return MainCardTitleData(
                          title: "Upcoming", imageUrl: movies);
                    },
                  ),
                  kHeight,
                ],
              ));
  }
}
