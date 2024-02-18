import 'package:equatable/equatable.dart';

import '../../models/translator.dart';

abstract class TranslateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TranslateEventClearBox extends TranslateEvent {}

class TranslateEventTranslator extends TranslateEvent {
  final String text;
  final String originalLang;
  final String translatorLang;
  TranslateEventTranslator(
      {required this.text,
      required this.originalLang,
      required this.translatorLang});
  @override
  List<Object> get props => [text, originalLang, translatorLang];
}

class TranslateEventAddBookMark extends TranslateEvent {
  final Translator translator;
  TranslateEventAddBookMark({required this.translator});
  @override
  List<Object> get props => [translator];
}

class TranslateEventRemoveFromDatabase extends TranslateEvent {
  final String originalWord;
  final String tableName;
  TranslateEventRemoveFromDatabase(
      {required this.originalWord, required this.tableName});
  @override
  List<Object> get props => [originalWord, tableName];
}

class TranslateEventClearAll extends TranslateEvent {}

class TranslateEventGetData extends TranslateEvent {
  final String tableName;
  TranslateEventGetData({required this.tableName});
  @override
  List<Object> get props => [tableName];
}

class TranslateEventCheckExistBookMark extends TranslateEvent {
  final String originalWord;
  TranslateEventCheckExistBookMark({required this.originalWord});
  @override
  List<Object> get props => [originalWord];
}

class TranslateEventInitial extends TranslateEvent {}
