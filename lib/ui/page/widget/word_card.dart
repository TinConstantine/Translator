import 'package:dich_x_noi_tu/global.dart';
import 'package:flutter/material.dart';

Widget wordCard({String? vieWord, String? engWord}) {
  return Card(
    color: colorAppBar.withAlpha(25),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          word(
              language: 'en',
              translateWord: engWord,
              icon: IconButton(onPressed: () {}, icon: const Icon(Icons.star))),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 35),
            child: Container(
              height: 1,
              color: colorBlack,
            ),
          ),
          word(
            language: 'vi',
            translateWord: vieWord,
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
