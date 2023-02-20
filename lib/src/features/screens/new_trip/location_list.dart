import 'package:flutter/material.dart';

import '../../../size_config/size_config.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon(Icons.location_pin),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: getScreenWidth(15),
                color: Color.fromARGB(235, 68, 68, 68)),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: Color.fromARGB(209, 212, 212, 212),
        ),
      ],
    );
  }
}
