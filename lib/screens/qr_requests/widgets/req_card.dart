import 'package:flutter/material.dart';
import 'package:hex_view/model/request_message.dart';
import 'package:hex_view/shared/constants/request_category.dart';

class RequestCard extends StatelessWidget {
  final Function() openDetailOverlay;
  final RequestMessages requestMessage;
  const RequestCard({
    super.key,
    required this.openDetailOverlay,
    required this.requestMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xfff5f6f7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: requestMessage.isRead == 'true'
              ? Colors.grey.shade200
              : const Color(0xff0f2138), // Set the border color here
          width: 2.0, // Set the border width
        ),
      ),
      child: ListTile(
        trailing: const Icon(
          Icons.arrow_right,
          size: 12,
        ),
        leading: const Icon(
          Icons.car_crash,
        ),
        title: Text(
          kCategoryOptions[requestMessage.category]!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
              '${requestMessage.timeStamp.hour}:${requestMessage.timeStamp.minute} • ${requestMessage.timeStamp.day}/${requestMessage.timeStamp.month}/${requestMessage.timeStamp.year}'),
        ),
        onTap: openDetailOverlay,
      ),
    );
  }
}