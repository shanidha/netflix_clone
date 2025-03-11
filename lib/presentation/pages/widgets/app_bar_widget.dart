import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      this.isChange = false,
      required this.title,
      required this.onTap});
  final String title;
  final VoidCallback onTap;
  final bool isChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kWidth,
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        kWidth,
        isChange
            ? IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ))
            : const Icon(
                Icons.download,
                color: Colors.white,
                size: 30,
              ),
        kWidth,
        isChange
            ? const Icon(
                Icons.list,
                color: Colors.white,
                size: 30,
              )
            : IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                )),
        // Container(
        //   width: 30,
        //   height: 30,
        //   color: Colors.blue,
        // ),
        kWidth,
      ],
    );
  }
}
