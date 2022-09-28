import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetHeader extends StatelessWidget {
  final String text;

  const WidgetHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black) ,
        ),
      ],
    );
  }
}
