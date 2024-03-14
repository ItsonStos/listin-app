import 'package:flutter/material.dart';

class ListinTile extends StatelessWidget {
  final Widget icon;
  final String id;
  final String name;

  const ListinTile({
    super.key,
    required this.icon,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(id),
              ],
            )
          ],
        ),
      ),
    );
  }
}
