import 'package:dich_x_noi_tu/global.dart';
import 'package:flutter/material.dart';

Widget leftDrawer() {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Image.asset(logo),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Translate on the Go',
          style: robotoMedium(color: colorBlack, size: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        options(icon: Icons.share, title: 'Share App', onTap: () {}),
        options(icon: Icons.star, title: 'Rate App', onTap: () {}),
        options(icon: Icons.shield, title: 'Privacy Policy', onTap: () {}),
        options(icon: Icons.feedback, title: 'Feed Back', onTap: () {})
      ],
    ),
  );
}

Widget options({IconData? icon, String? title, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: robotoRegular(color: colorBlack, size: 20),
          )
        ],
      ),
    ),
  );
}
