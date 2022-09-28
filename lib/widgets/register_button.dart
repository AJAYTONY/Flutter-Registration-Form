import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {Key? key,
        this.onPressed,
        required this.text,
        this.btnColor,
        this.childColor})
      : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color? btnColor;
  final Color? childColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0.4,
          blurRadius: 4,
          offset: const Offset(1, 1),
        ),
      ]),
      width: double.infinity,
      height: 50,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              btnColor ?? Colors.white,
            ),
            foregroundColor: MaterialStateProperty.all(
              childColor ?? Colors.white,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // const Icon(
              //   Icons.arrow_forward_ios_rounded,
              //   size: 16,
              // )
            ],
          )),
    );
  }
}