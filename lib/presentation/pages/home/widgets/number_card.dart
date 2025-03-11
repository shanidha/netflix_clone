import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';


import '../../../../core/constants.dart';



class NumberCardWidget extends StatelessWidget {
  const NumberCardWidget({super.key, required this.index, required this.url});
  final int index;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 250,
            ),
             
            Container(
              width: 150,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: kRadius20,
                  image:  DecorationImage(fit: BoxFit.cover,
                    image: NetworkImage(url))),
            ),
         
          ],
          
        ),
          Positioned(
            left: 13,
            bottom: -30,
            child: BorderedText(
              strokeWidth: 10,
              strokeColor: kWhiteColor,
              child: Text("${index+1}",
              style: const TextStyle(
         fontWeight: FontWeight.bold,
              fontSize: 150,color: kBlackColor,decoration: TextDecoration.none,decorationColor: kBlackColor),)),),
      ],
    );
  }
}
