import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:dich_x_noi_tu/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';

import '../repositories/database.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateStateInitial()) {
    DatabaseHelper db = DatabaseHelper();
    on<TranslateEventTranslator>((event, emit) async {
      final database = await db.database;
      final translator = GoogleTranslator();
      emit(TranslateStateLoading());
      var res = await translator.translate(event.text,
          from: event.originalLang, to: event.translatorLang);
      await db.insertData(database,
          originalLang: event.originalLang,
          translatorLang: event.translatorLang,
          originalWord: event.text,
          translatorWord: res.text,
          tableName: historyTable);
      emit(TranslateStateSucessfully(text: res.text, isShow: true));
    });

    on<TranslateEventClearBox>((event, emit) => emit(TranslateStateClearBox()));
    on<TranslateEventGetData>((event, emit) async {
      emit(TranslateStateLoading());
      final database = await db.database;
      final data = await db.getData(database, tableName: event.tableName);
      emit(TranslateStateGetDataFromTableSuccessfuly(translators: data));
    });
    on<TranslateEventClearAll>((event, emit) async {
      emit(TranslateStateLoading());
      final database = await db.database;
      await db.deletaAllData(database, tableName: historyTable);
      emit(TranslateStateDeleteSucessfuly());
    });
    on<TranslateEventAddBookMark>((event, emit) async {
      final database = await db.database;
      await db.insertData(database,
          tableName: bookMarkTable,
          originalLang: event.translator.originalLang,
          originalWord: event.translator.originalWord,
          translatorLang: event.translator.translatorLang,
          translatorWord: event.translator.translatorWord);
      emit(TranslateStateAddToDatabseSucccesfuly());
    });
    on<TranslateEventCheckExistBookMark>((event, emit) async {
      final database = await db.database;
      final isExist = await db.checkExist(database,
          tableName: bookMarkTable, originalWord: event.originalWord);
      emit(TranslateStateCheckExistBookMark(isExist: isExist));
    });
    on<TranslateEventRemoveFromDatabase>((event, emit) async {
      final database = await db.database;
      await db.deleteAItem(database,
          tableName: event.tableName, originalWord: event.originalWord);
      emit(TranslateStateDeleteSucessfuly());
    });
    on<TranslateEventInitial>((event, emit) => emit(TranslateStateInitial()));
  }
}
