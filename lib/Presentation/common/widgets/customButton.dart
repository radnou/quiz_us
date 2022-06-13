import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffE6812F),
            borderRadius: BorderRadius.circular(10.0)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
