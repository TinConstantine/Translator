import 'package:dich_x_noi_tu/bloc/events/app_event.dart';
import 'package:dich_x_noi_tu/bloc/states/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppStateInitial()) {
    on<AppEventChange>((event, emit) => emit(AppStateChange(lang: event.lang)));
  }
}
