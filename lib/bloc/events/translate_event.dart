import 'package:equatable/equatable.dart';

import '../../models/translator.dart';

abstract class TranslateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TranslateEventTranslator extends TranslateEvent {
  final String text;

  TranslateEventTranslator({required this.text});
  @override
  List<Object> get props => [text];
}

class TranslateEventAddToDatabase extends TranslateEvent {
  final Translator translator;
  final bool addToFavourite;
  TranslateEventAddToDatabase(
      {required this.translator, this.addToFavourite = false});
  @override
  List<Object> get props => [translator, addToFavourite];
}

class TranslateEventRemoveFromDatabase extends TranslateEvent {
  final bool tableName;
  final String primaryKey;
  final bool deleteAllHistory;
  TranslateEventRemoveFromDatabase(
      {this.deleteAllHistory = false,
      required this.primaryKey,
      required this.tableName});
  @override
  List<Object> get props => [primaryKey, tableName, deleteAllHistory];
}

class TranslateEventGetData extends TranslateEvent {
  final String tableName;
  TranslateEventGetData({required this.tableName});
  @override
  List<Object> get props => [tableName];
}
