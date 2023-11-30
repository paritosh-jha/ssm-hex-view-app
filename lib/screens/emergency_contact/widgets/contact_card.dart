import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';


class ContactCard extends StatefulWidget {
  final int index;
  final String contactName, contactNumber;
  final Function(BuildContext, String) showUpdateBottomSheet;
  const ContactCard({
    super.key,
    required this.index,
    required this.contactName,
    required this.contactNumber,
    required this.showUpdateBottomSheet,
  });

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Emergency Contact Info - ${widget.index + 1}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade100)),
              onPressed: () {
                widget.showUpdateBottomSheet(context,widget.contactName);
              },
              icon: const Icon(
                FluentIcons.edit_16_filled,
                size: 15,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Name'),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          title: Text(widget.contactName),
          leading: const Icon(FluentIcons.person_16_filled),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Contact Number'),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          title: Text(widget.contactNumber),
          leading: const Icon(FluentIcons.call_16_filled),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
