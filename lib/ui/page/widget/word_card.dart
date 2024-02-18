import 'package:dich_x_noi_tu/global.dart';
import 'package:flutter/material.dart';

Widget wordCard(
    {String? originalLang,
    String? translatorLang,
    String? originalWord,
    String? translatorWord,
    IconData? icon,
    void Function()? onPressed}) {
  bool isShowIcon = icon != null;
  return Card(
    color: colorAppBar.withAlpha(25),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          word(
              language: originalLang,
              translateWord: originalWord,
              icon: isShowIcon
                  ? IconButton(onPressed: onPressed, icon: Icon(icon))
                  : null),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 35),
            child: Container(
              height: 1,
              color: colorBlack,
            ),
          ),
          word(
            language: translatorLang,
            translateWord: translatorWord,
          )
        ],
      ),
    ),
  );
}

Widget word({String? language, String? translateWord, IconButton? icon}) {
  return ListTile(
    leading: Text(
      language!,
      style: robotoMedium(color: colorBlack, size: 16),
    ),
    title: Text(translateWord!, maxLines: 1, overflow: TextOverflow.fade),
    trailing: icon,
  );
}
