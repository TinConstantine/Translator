import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dich_x_noi_tu/bloc/events/translate_event.dart';
import 'package:dich_x_noi_tu/bloc/translate_bloc.dart';
import 'package:dich_x_noi_tu/ui/page/book_mark.dart';
import 'package:dich_x_noi_tu/ui/page/camera_page.dart';
import 'package:dich_x_noi_tu/ui/page/history_page.dart';
import 'package:dich_x_noi_tu/ui/page/translate_page.dart';
import 'package:dich_x_noi_tu/ui/page/widget/app_bar.dart';
import 'package:dich_x_noi_tu/ui/page/words_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../global.dart';
import 'page/widget/left_drawer.dart';

class ScreenApp extends StatefulWidget {
  const ScreenApp({super.key});

  @override
  State<ScreenApp> createState() => _ScreenAppState();
}

class _ScreenAppState extends State<ScreenApp> {
  int _currentIndex = 2;
  AppBar _myAppBar = AppBar();
  void backToHomePage() {
    setState(() {
      _currentIndex = 2;
    });
  }

  void _appBar() {
    switch (_currentIndex) {
      case 0:
        _myAppBar =
            customAppBar(title: "Vietnamese Word", onPressed: backToHomePage);
        break;
      case 1:
        _myAppBar = customAppBar(title: "Camera", onPressed: backToHomePage);
        break;
      case 2:
        _myAppBar =
            customAppBar(title: "Language Translate", showLeading: false);
        break;
      case 3:
        _myAppBar =
            customAppBar(title: "History", onPressed: backToHomePage, actions: [
          TextButton(
              onPressed: () {
                context.read<TranslateBloc>().add(TranslateEventClearAll());
              },
              child: const Text('Clear all'))
        ]);
        break;
      case 4:
        _myAppBar = customAppBar(title: "Favourite", onPressed: backToHomePage);
    }
  }

  final List<Widget> _listScreen = [
    const WordsPage(),
    const CameraPage(),
    TranslatePage(),
    const HistoryPage(),
    const BookMarkPage(),
  ];
  final List<TabItem> _listItem = const [
    TabItem(
        icon: Icon(
          Icons.book,
          color: colorWhite,
        ),
        title: "Words"),
    TabItem(
      icon: Icon(
        Icons.camera_alt,
        color: colorWhite,
      ),
      title: "Camera",
    ),
    TabItem(
        icon: Icon(
          Icons.translate_sharp,
          size: 35,
          color: colorAppBar,
        ),
        title: ""),
    TabItem(
      icon: Icon(Icons.history, color: colorWhite),
      title: "History",
    ),
    TabItem(
        icon: Icon(
          Icons.star_border,
          color: colorWhite,
        ),
        title: "Favourite"),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      _appBar();
    });
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _myAppBar,
        drawer: _currentIndex == 2 ? leftDrawer() : null,
        bottomNavigationBar: _bottomNavigationBar(),
        body: _listScreen[_currentIndex],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      items: _listItem,
      initialActiveIndex: _currentIndex,
      activeColor: colorWhite.withAlpha(255),
      backgroundColor: colorAppBar.withAlpha(100),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
