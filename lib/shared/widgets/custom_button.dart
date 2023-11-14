import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  final String label;
  final Icon icon;
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
              Icons.arrow_forward_outlined,
              color: outlined ? Colors.black87 : iconColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}

class CustomOutlinedTextButton extends StatelessWidget {
  final String label;
  final Function() onpressed;
  final bool outlined;
  const CustomOutlinedTextButton(
      {super.key,
      required this.label,
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
          ],
        ),
      ),
    );
  }
}
