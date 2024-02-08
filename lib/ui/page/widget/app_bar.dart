import 'package:dich_x_noi_tu/global.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(
    {required String title,
    List<Widget>? actions,
    bool showLeading = true,
    void Function()? onPressed}) {
  return AppBar(
    backgroundColor: colorAppBar,
    leading: showLeading
        ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: onPressed)
        : null,
    title: Text(
      title,
      style: robotoMedium(color: colorWhite),
    ),
    actions: actions,
  );
}
