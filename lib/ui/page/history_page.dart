import 'package:dich_x_noi_tu/ui/page/widget/word_card.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: wordCard(
        engWord: 'Hellooooooooooooooooooooooooooooooooooooooooooo',
        vieWord: 'Xin chào',
      ),
    );
  }
}
