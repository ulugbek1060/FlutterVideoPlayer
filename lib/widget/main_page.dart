import 'package:flutter/material.dart';
import 'package:video_player_sample/main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).push(MyHomePage.route("Video"));
          },
          child: Text("Open Movie"),
        ),
      ),
    );
  }
}
