import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  bool isShow = false;

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
        }
        return Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(children: [
              _language(),
              const SizedBox(height: 20),
              _originalWordsBox(context, controller: _originalTextController),
              const SizedBox(height: 20),
              if (isShow)
                _translateWordsBox(context,
                    controller: _translateTextController)
            ]));
      },
    );
  }

  Widget _language() {
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
            _boxFlagLeft(img: flagEng, language: "English"),
            IconButton(onPressed: () {}, icon: const Icon(Icons.swap_horiz)),
            _boxFlagRight(img: flagVie, language: "Việt Nam"),
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
  }) {
    return _translateBox(context, controller: controller, onPressedDelete: () {
      setState(() {
        _originalTextController.clear();
        isShow = false;
      });
    },
        language: 'English',
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
                context
                    .read<TranslateBloc>()
                    .add(TranslateEventTranslator(text: controller.text));
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
      {required TextEditingController controller}) {
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
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: colorAppBar,
              ))
        ],
      ),
      language: 'Việt Nam',
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
