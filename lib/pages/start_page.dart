import 'package:flutter/material.dart';
import 'package:blogit/color_palette.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final videoURL = 'https://www.youtube.com/watch?v=4AoFA19gbLo';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        hideControls: false,
        autoPlay: false,
        mute: true,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.05,
                  0.2,
                  0.75,
                  9.0,
                ],
                colors: [
                  Colors.white,
                  Color(0xffEAEAEA),
                  Color(0xffEAEAEA),
                  Color(0xffddd0c8),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'blog it',
                    style: TextStyle(
                      color: Palette.themeColor[600],
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Write. Read. Sleep. Repeat.',
                    style: TextStyle(
                      color: Palette.themeColor[600],
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ColorFiltered(
                    colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                    child: Image.asset('assets/start.jpg'),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Palette.themeColor[600]!)
                      ),
                      child: const Text(
                        'START NOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'APP MADE WITH',
                    style: TextStyle(
                      color: Palette.themeColor[600],
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}