import 'package:dich_x_noi_tu/models/translator.dart';
import 'package:equatable/equatable.dart';

abstract class TranslateState extends Equatable {
  @override
  List<Object> get props => [];
}

class TranslateStateSucessfully extends TranslateState {
  final String text;
  final bool isShow;
  TranslateStateSucessfully({required this.text, required this.isShow});
  @override
  List<Object> get props => [text, isShow];
}

class TranslateStateIsFavourite extends TranslateState {
  final bool isFavourite;
  TranslateStateIsFavourite({required this.isFavourite});
  @override
  List<Object> get props => [isFavourite];
}

class TranslateStateGetDataFromTableSuccessfuly extends TranslateState {
  final List<Translator> translators;
  TranslateStateGetDataFromTableSuccessfuly({required this.translators});
  @override
  List<Object> get props => [translators];
}

class TranslateStateAddToDatabseSucccesfuly extends TranslateState {}

class TranslateStateDeleteSucessfuly extends TranslateState {}

class TranslateStateInitial extends TranslateState {}

class TranslateStateLoading extends TranslateState {}

class TranslateStateClearBox extends TranslateState {}

class TranslateStateCheckExistBookMark extends TranslateState {
  final bool isExist;
  TranslateStateCheckExistBookMark({required this.isExist});
  @override
  List<Object> get props => [isExist];
}
