import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String label, value;
  final Color backgroundColor;
  const InfoCard(
      {super.key,
      required this.label,
      required this.value,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.8),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
