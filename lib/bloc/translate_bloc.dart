import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/states/translate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateStateInitial()) {
    on<TranslateEventTranslator>((event, emit) async {
      final translator = GoogleTranslator();
      emit(TranslateStateLoading());
      var res = await translator.translate(event.text, from: "en", to: 'vi');
      emit(TranslateStateSucessfully(text: res.text, isShow: true));
    });
  }
}
