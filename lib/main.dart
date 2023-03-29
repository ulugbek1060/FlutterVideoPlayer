import 'package:flutter/material.dart';
import 'package:video_player_sample/widget/main_page.dart';
import 'package:video_player_sample/widget/video_player_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Video Controls';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MainPage(),
      );
}

class MyHomePage extends StatelessWidget {
  static Route<void> route(String title) =>
      MaterialPageRoute(builder: (_) => MyHomePage(title: title));

  final String title;

  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const SingleChildScrollView(
          child: VideoPlayerWidget(
            timestamps: <Duration>[
              Duration(minutes: 0, seconds: 14),
              Duration(minutes: 0, seconds: 48),
              Duration(minutes: 1, seconds: 18),
              Duration(minutes: 1, seconds: 47),
            ],
          ),
        ),
      );
}
