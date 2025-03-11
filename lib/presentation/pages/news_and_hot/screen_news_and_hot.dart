import 'package:flutter/material.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../domain/core/api/api_calls.dart';
import '../search/screen_search.dart';
import 'widgets/coming_soon_widget.dart';
import 'widgets/every_ones_watching_widget.dart';

class ScreenNewsAndHot extends StatefulWidget {
  const ScreenNewsAndHot({super.key});

  @override
  State<ScreenNewsAndHot> createState() => _ScreenNewsAndHotState();
}

class _ScreenNewsAndHotState extends State<ScreenNewsAndHot> {
  final ValueNotifier<List> comingSoonMovies = ValueNotifier([]);
  final ValueNotifier<List> everyonesWatchingMovies = ValueNotifier([]);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch API data on screen load
  }

  /// **Fetch Data Using API Service**
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      comingSoonMovies.value = await fetchComingSoon();
      everyonesWatchingMovies.value = await fetchEveryonesWatching();
    } catch (e) {
      debugPrint("Error fetching News & Hot data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: kWhiteColor),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenSearch()),
                  );
                },
              )
            ],
            bottom: TabBar(
              dividerColor: kBlackColor,
              labelColor: kBlackColor,
              unselectedLabelColor: kWhiteColor,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: kWhiteColor,
                borderRadius: kRadius30,
              ),
              tabs: const [
                Tab(text: "🍿 Coming Soon"),
                Tab(text: "👀 Everyone's Watching"),
              ],
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.red))
            : TabBarView(
                children: [
                  ValueListenableBuilder(
                    valueListenable: comingSoonMovies,
                    builder: (context, List movies, _) {
                      return _buildComingSoon(movies);
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: everyonesWatchingMovies,
                    builder: (context, List movies, _) {
                      return _buildEveryonesWatching(movies);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  /// **Coming Soon List**
  Widget _buildComingSoon(List movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ComingSoonWidget(movie: movies[index]);
      },
    );
  }

  /// **Everyone's Watching List**
  Widget _buildEveryonesWatching(List movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return EveryOnesWatchingWidget(movie: movies[index]);
      },
    );
  }
}
