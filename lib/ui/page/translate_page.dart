import 'package:dich_x_noi_tu/bloc/app_bloc.dart';
import 'package:dich_x_noi_tu/bloc/events/app_event.dart';
import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/app_state.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:dich_x_noi_tu/models/language.dart';
import 'package:dich_x_noi_tu/models/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global.dart';

class TranslatePage extends StatelessWidget {
  TranslatePage({super.key});

  bool isShow = false;
  bool isExist = false;
  late String _originalLang;

  late String _translatorLang;

  late String _originalLangFlag;

  late String _translatorLangFlag;

  late Language _currentLanguage;

  final TextEditingController _originalTextController = TextEditingController();

  final TextEditingController _translateTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateBloc, TranslateState>(
      builder: (context, state) {
        if (state is TranslateStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TranslateStateSucessfully) {
          isShow = true;
          _translateTextController.text = state.text;
        } else if (state is TranslateStateClearBox) {
          isShow = false;
          _translateTextController.clear();
          _originalTextController.clear();
        } else if (state is TranslateStateCheckExistBookMark) {
          isExist = state.isExist;
          // } else if (state is TranslateStateDeleteSucessfuly) {
          //   isExist = false;
        }
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppStateChange) {
              _currentLanguage = state.lang;

              switch (state.lang.originalLang) {
                case LanguageEnum.en:
                  _originalLang = "English";
                  _originalLangFlag = flagEng;
                  _translatorLang = "Việt Nam";
                  _translatorLangFlag = flagVie;
                  break;
                case LanguageEnum.vi:
                  _originalLang = "Việt Nam";
                  _originalLangFlag = flagVie;
                  _translatorLang = "English";
                  _translatorLangFlag = flagEng;
                  break;
              }
              return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(children: [
                    _language(context,
                        leftBoxFlag: _originalLangFlag,
                        leftBoxLang: _originalLang,
                        rightBoxFlag: _translatorLangFlag,
                        rightBoxLang: _translatorLang, onpress: () {
                      dynamic temp;
                      temp = _originalTextController.text;
                      _originalTextController.text =
                          _translateTextController.text;
                      _translateTextController.text = temp;
                      final swapLang = Language(
                          originalLang: _currentLanguage.translatorLang,
                          translatorLang: _currentLanguage.originalLang);

                      context
                          .read<AppBloc>()
                          .add(AppEventChange(lang: swapLang));
                    }),
                    const SizedBox(height: 20),
                    _originalWordsBox(context,
                        controller: _originalTextController,
                        language: _originalLang),
                    const SizedBox(height: 20),
                    if (isShow)
                      _translateWordsBox(context,
                          controller: _translateTextController,
                          language: _translatorLang)
                  ]));
            }
            return const Placeholder();
          },
        );
      },
    );
  }

  Widget _language(BuildContext context,
      {required String leftBoxLang,
      required String leftBoxFlag,
      required String rightBoxLang,
      required String rightBoxFlag,
      required void Function()? onpress}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorAppBar.withAlpha(100),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _boxFlagLeft(img: leftBoxFlag, language: leftBoxLang),
            IconButton(onPressed: onpress, icon: const Icon(Icons.swap_horiz)),
            _boxFlagRight(img: rightBoxFlag, language: rightBoxLang),
          ],
        ),
      ),
    );
  }

  Widget _boxFlagLeft({String? img, String? language}) {
    return Row(
      children: [
        Container(
          height: 24,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(img!),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          language!,
          style: robotoMedium(size: 16, color: colorBlack),
        )
      ],
    );
  }

  Widget _boxFlagRight({String? img, String? language}) {
    return Row(
      children: [
        Text(
          language!,
          style: robotoMedium(size: 16, color: colorBlack),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 24,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(img!),
        ),
      ],
    );
  }

  Widget _originalWordsBox(
    BuildContext context, {
    required TextEditingController controller,
    required String language,
  }) {
    return _translateBox(context, controller: controller, onPressedDelete: () {
      context.read<TranslateBloc>().add(TranslateEventClearBox());
    },
        language: language,
        bottomBox: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic),
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder()),
                  backgroundColor: MaterialStatePropertyAll(colorAppBar)),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TranslateBloc>().add(TranslateEventTranslator(
                    text: controller.text.trim(),
                    originalLang: _currentLanguage.originalLang.name,
                    translatorLang: _currentLanguage.translatorLang.name));
                context.read<TranslateBloc>().add(
                    TranslateEventCheckExistBookMark(
                        originalWord: controller.text.trim()));
                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(colorOrange),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)))),
              child: Text(
                'Translate',
                style: robotoMedium(color: colorWhite, size: 14),
              ),
            )
          ],
        ),
        hintText: 'Enter text here...');
  }

  Widget _translateWordsBox(BuildContext context,
      {required TextEditingController controller, required String language}) {
    return _translateBox(
      context,
      controller: controller,
      bottomBox: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.copy,
                color: colorAppBar,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: colorAppBar,
              )),
          IconButton(
              onPressed: () {
                final translator = Translator(
                    originalWord: _originalTextController.text.trim(),
                    translatorWord: _translateTextController.text.trim(),
                    originalLang: _originalLang,
                    translatorLang: _translatorLang);

                if (isExist) {
                  context.read<TranslateBloc>().add(
                      TranslateEventRemoveFromDatabase(
                          originalWord: translator.originalWord,
                          tableName: bookMarkTable));
                } else {
                  context
                      .read<TranslateBloc>()
                      .add(TranslateEventAddBookMark(translator: translator));
                }
                context.read<TranslateBloc>().add(
                    TranslateEventCheckExistBookMark(
                        originalWord: translator.originalWord.trim()));
              },
              icon: Icon(
                isExist ? Icons.star : Icons.star_border,
                color: colorAppBar,
              ))
        ],
      ),
      language: language,
      readOnly: true,
      deleteButton: false,
    );
  }

  Widget _translateBox(BuildContext context,
      {String? language,
      bool deleteButton = true,
      required Widget bottomBox,
      bool readOnly = false,
      String? hintText,
      required TextEditingController controller,
      void Function()? onPressedDelete}) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorAppBar.withAlpha(100)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language!,
                      style: robotoMedium(color: colorAppBar, size: 16),
                    ),
                    if (deleteButton)
                      IconButton(
                          onPressed: onPressedDelete,
                          icon: const Icon(Icons.close))
                  ],
                ),
                TextFormField(
                  controller: controller,
                  readOnly: readOnly,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: hintText),
                ),
              ],
            ),
            bottomBox,
          ],
        ),
      ),
    );
  }
}
