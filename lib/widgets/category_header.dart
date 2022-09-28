import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String text;

  const CategoryHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(
        //   height: 10,
        // ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black) ,
        ),
      ],
    );
  }
}
