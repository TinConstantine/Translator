import 'package:dich_x_noi_tu/models/language.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppEventChange extends AppEvent {
  final Language lang;
  AppEventChange({required this.lang});
  @override
  List<Object> get props => [lang];
}
