import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:dich_x_noi_tu/global.dart';
import 'package:dich_x_noi_tu/models/translator.dart';
import 'package:dich_x_noi_tu/ui/page/widget/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TranslateBloc>().add(TranslateEventInitial());
    context
        .read<TranslateBloc>()
        .add(TranslateEventGetData(tableName: bookMarkTable));
    return BlocBuilder<TranslateBloc, TranslateState>(
      builder: (context, state) {
        if (state is TranslateStateGetDataFromTableSuccessfuly) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: WordCardBookMark(
                translators: state.translators,
              ));
        } else if (state is TranslateStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TranslateStateDeleteSucessfuly) {
          context
              .read<TranslateBloc>()
              .add(TranslateEventGetData(tableName: bookMarkTable));
        }
        return const Text(" ");
      },
    );
  }
}

class WordCardBookMark extends StatefulWidget {
  const WordCardBookMark({super.key, required this.translators});
  final List<Translator> translators;

  @override
  State<WordCardBookMark> createState() => _WordCardBookMarkState();
}

class _WordCardBookMarkState extends State<WordCardBookMark> {
  bool isFavourite = true;

  late Map<Translator, bool> removeFav;
  @override
  void initState() {
    super.initState();
    removeFav = {for (var item in widget.translators) item: true};
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: removeFav.length,
      itemBuilder: (context, index) {
        final key = removeFav.keys.elementAt(index);
        return InkWell(
          onTap: () {
            setState(() {
              removeFav[key] = !removeFav[key]!;
              if (removeFav[key]! == false) {
                context.read<TranslateBloc>().add(
                    TranslateEventRemoveFromDatabase(
                        originalWord: key.originalWord,
                        tableName: bookMarkTable));
              }
            });
          },
          child: wordCard(
            originalLang: key.originalLang,
            originalWord: key.originalWord,
            translatorLang: key.translatorLang,
            translatorWord: key.translatorWord,
            icon: removeFav[key]! ? Icons.star : Icons.star_border,
          ),
        );
      },
    );
  }
}
