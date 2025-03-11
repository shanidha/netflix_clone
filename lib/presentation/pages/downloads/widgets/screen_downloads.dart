import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants.dart';
import '../../../../domain/core/api/api_calls.dart';
import '../../../../domain/core/models/download_model.dart';


class ScreenDownloads extends StatefulWidget {
  const ScreenDownloads({
    super.key,
  });

  @override
  State<ScreenDownloads> createState() => _ScreenDownloadsState();
}

class _ScreenDownloadsState extends State<ScreenDownloads> {
  bool _isLoading = false;
  String image = "";
  String title = "";
  String subTitle = "";
  List imageList = [];
  @override
  void initState() {
    fetchDownloads();
    super.initState();
  }
//Function to Call Datas
  void fetchDownloads() async {
    setState(() {
      _isLoading = true;
    });
    try {
      DownloadsData? data = await getDownloadsData();
      if (data != null && data.downloads.posters.isNotEmpty) {
        setState(() {
          imageList = data.downloads.posters;
          title = data.downloads.title;
          image = data.downloads.posterPath;
          subTitle = data.downloads.subtitle;
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
    final size = MediaQuery.of(context).size;
    final widgetList = [
      kHeight20,
      const _SmartDownloads(),
      kHeight20,
      _buildName(),
      kHeight20,
      BuildNewTileWidget(image: image, title: title, subTitle: subTitle),
      Section2(size: size, imageList: imageList),
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: downloadAppBar(context),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : ListView.separated(
              //   physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: widgetList.length,
              itemBuilder: (context, index) => widgetList[index],
              separatorBuilder: (context, index) => const SizedBox(
                height: 0,
              ),
            ),
    );
  }
//App Bar
  AppBar downloadAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: kWhiteColor, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("Downloads", style: headerStyle),
      centerTitle: true, 
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: kWhiteColor),
          onPressed: () {},
        ),
      ],
    );
  }
//Build Avatar
  ListTile _buildName() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          'assets/images/Netflix-avatar.png',
          fit: BoxFit.contain,
        ),
      ),
      title: const Text(
        "Adam",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: kWhiteColor),
      ),
    );
  }
}
//Build New Tile in Download Screen
class BuildNewTileWidget extends StatelessWidget {
  const BuildNewTileWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.network(
          image,
          fit: BoxFit.contain,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: kWhiteColor),
          ),
          Text(
            subTitle,
            style: const TextStyle(color: kWhiteColor),
          ),
        ],
      ),
      const Icon(
        Icons.chevron_right,
        color: kWhiteColor,
        size: 40,
      ),
    ]);
  }
}
//Section 
class Section2 extends StatelessWidget {
  const Section2({
    super.key,
    required this.size,
    required this.imageList,
  });

  final Size size;
  final List imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.only(top: 50, bottom: 90, left: 20, right: 20),
      child: Column(
        children: [
          const Text(
            "Introducing Downloads For you",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight,
          const Text(
            "We'll download a personalised selection\nof movies and shows for you, so there's\nalways something to watch on your\ndevice.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 14,
            ),
          ),
          kHeight,
          SizedBox(
            width: size.width,
            height: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: size.width * 0.3,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                ),
                DownloadsImageWidget(
                  imageListUrl: imageList[2],
                  angle: 18,
                  size: Size(size.width * 0.35, size.width * 0.55),
                  margin: const EdgeInsets.only(left: 160, bottom: 10),
                ),
                DownloadsImageWidget(
                  imageListUrl: imageList[0],
                  angle: -18,
                  size: Size(size.width * 0.35, size.width * 0.55),
                  margin: const EdgeInsets.only(right: 160, bottom: 10),
                ),
                DownloadsImageWidget(
                  imageListUrl: imageList[1],
                  borderRadius: 8,
                  size: Size(size.width * 0.4, size.width * 0.6),
                  margin: const EdgeInsets.only(bottom: 35, top: 50),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
            child: SizedBox(
              width: double.infinity,
              child: MaterialButton(
                color: kButtonColorBlue,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Set Up",
                    style: TextStyle(
                        fontSize: 20,
                        color: kWhiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            color: kButtonColorWhite,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                "See What you\ncan download",
                style: TextStyle(
                    fontSize: 20,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        kWidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text("Smart Downloads"),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {super.key,
      required this.imageListUrl,
      this.borderRadius = 5,
      this.angle = 0,
      required this.size,
      required this.margin});

  final String imageListUrl;
  final double angle;
  final double borderRadius;
  final EdgeInsets margin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          margin: margin,
          width: size.width,
          height: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(
                  //   fit: BoxFit.cover,
                  image: NetworkImage(imageListUrl))),
        ),
      ),
    );
  }
}
