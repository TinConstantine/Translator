import 'package:dich_x_noi_tu/models/language.dart';
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStateChange extends AppState {
  final Language lang;
  AppStateChange({required this.lang});
  @override
  List<Object> get props => [lang];
}

class AppStateInitial extends AppState {}
