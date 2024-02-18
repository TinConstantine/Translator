import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:dich_x_noi_tu/global.dart';
import 'package:dich_x_noi_tu/ui/page/widget/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<TranslateBloc>()
        .add(TranslateEventGetData(tableName: bookMarkTable));
    context
        .read<TranslateBloc>()
        .add(TranslateEventGetData(tableName: historyTable));
    return BlocBuilder<TranslateBloc, TranslateState>(
      builder: (context, state) {
        if (state is TranslateStateGetDataFromTableSuccessfuly) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.translators.length,
              itemBuilder: (context, index) {
                final translator = state.translators[index];
                return wordCard(
                    originalLang: translator.originalLang,
                    originalWord: translator.originalWord,
                    translatorLang: translator.translatorLang,
                    translatorWord: translator.translatorWord);
              },
            ),
          );
        } else if (state is TranslateStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Text(" ");
      },
    );
  }
}
