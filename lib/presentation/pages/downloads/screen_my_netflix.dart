import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/core/api/api_calls.dart';
import 'package:netflix_clone/domain/core/models/netflix_model.dart';
import 'package:netflix_clone/presentation/pages/downloads/widgets/screen_downloads.dart';
import 'package:netflix_clone/presentation/pages/widgets/app_bar_widget.dart';
import 'package:netflix_clone/presentation/pages/widgets/main_title_card.dart';

import '../../../core/colors/colors.dart';
import '../search/screen_search.dart';

class ScreenDownload extends StatefulWidget {
  const ScreenDownload({super.key});

  @override
  State<ScreenDownload> createState() => _ScreenDownloadState();
}

class _ScreenDownloadState extends State<ScreenDownload> {
  bool _isLoading = false;
  List showList = [];
  List list = [];
  List imageList = [];
  @override
  void initState() {
    fetchDatas();
    super.initState();
  }

//Fetching my Netflix Dats
  void fetchDatas() async {
    setState(() {
      _isLoading = true;
    });
    try {
      NetflixModel? data = await getNetflixData();
      if (data != null && data.list.isNotEmpty) {
        setState(() {
          imageList = data.posters;
          list = data.list;
          showList = data.shows;
        });
      }
    } catch (_) {
    } finally {
      setState(() {
        _isLoading = false;
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
              title: "My Netflix",
              isChange: true,
            )),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : ListView(
                children: [
                  kHeight20,
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          'assets/images/Netflix-avatar.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Adam",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Icon(
                            Icons.expand_more,
                            color: kWhiteColor,
                          )
                        ],
                      )
                    ],
                  ),
                  kHeight20,
                  BuildTile(
                    onTap: () {},
                    title: "Notifications",
                    backgroundColor: kButtonColorBlue ?? Colors.blue,
                    icon: Icons.notifications_on_outlined,
                  ),
                  kHeight20,
                  BuildTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenDownloads()),
                      );
                    },
                    title: "Downloads",
                    backgroundColor: kRedColor,
                    icon: Icons.download,
                  ),
                  kHeight20,
                  MainCardTitle(
                      imageUrl: showList,
                      title: "Tv Shows & Movies You have Liked"),
                  kHeight20,
                  MainCardTitle(
                    title: "My List",
                    imageUrl: list,
                  ),
                  kHeight20,
                  MainCardTitle(
                    title: "Trailers You Have Watched",
                    imageUrl: imageList,
                  ),
                ],
              ));
  }
}

//Build a listtile for download and notification
class BuildTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;
  final String title;
  const BuildTile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
          radius: 25,
          backgroundColor: backgroundColor,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                color: kWhiteColor,
                size: 26,
              ))),
      title: Text(
        title,
        style: const TextStyle(
            color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: kWhiteColor,
      ),
    );
  }
}
