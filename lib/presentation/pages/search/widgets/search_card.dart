import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

import '../../../../core/constants.dart';




class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key, required this.imageUrl, required this.name, required this.action,
  });
  final String imageUrl;
    final String name;  final String action;
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.only(left:8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          
            width: 150,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
          
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl))),
          ),kHeight,
           SizedBox(    width: 150,
            child: Text(name,style:const TextStyle(color: kWhiteColor,fontWeight: FontWeight.bold),)),
             Text(action,style:const  TextStyle(color: kGreyColor,fontWeight: FontWeight.bold,fontSize: 11),),
        ],
      ),
    );
  }
}