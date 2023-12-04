import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Function() onpressed;
  final bool outlined;
  const CustomTextIconButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onpressed,
      required this.outlined,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onpressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: outlined
              ? const MaterialStatePropertyAll(Colors.white)
              : const MaterialStatePropertyAll(Colors.black87),
          side: MaterialStatePropertyAll(
            outlined
                ? const BorderSide(color: Colors.black87, width: 2)
                : const BorderSide(
                    color: Colors.transparent,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: outlined ? Colors.black87 : Colors.white,
                  fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: outlined ? Colors.black87 : iconColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onpressed;
  final bool outlined;
  final Color color;
  const CustomTextButton(
      {super.key,
      required this.label,
      this.color = Colors.black87,
      required this.onpressed,
      required this.outlined});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onpressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: outlined
              ? const MaterialStatePropertyAll(Colors.white)
              : MaterialStatePropertyAll(color),
          side: MaterialStatePropertyAll(
            outlined
                ? const BorderSide(color: Colors.black87, width: 2)
                : const BorderSide(
                    color: Colors.transparent,
                  ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: outlined ? Colors.black87 : Colors.white,
                  fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
