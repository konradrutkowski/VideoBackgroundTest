import 'package:flutter/material.dart';
import 'package:flutter_playout/multiaudio/MultiAudioSupport.dart';
import 'package:flutter_playout/player_observer.dart';
import 'package:flutter_playout/player_state.dart';
import 'package:flutter_playout/video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoPip(
        desiredState: PlayerState.PLAYING,
        showPlayerControls: true,
      ),
    );
  }
}

class VideoPip extends StatefulWidget with PlayerObserver {
  final PlayerState desiredState;
  final bool showPlayerControls;

  const VideoPip(
      {Key? key, required this.desiredState, required this.showPlayerControls})
      : super(key: key);

  @override
  VideoPipState createState() => VideoPipState();
}

class VideoPipState extends State<VideoPip>
    with PlayerObserver, MultiAudioSupport {
  final String _url =
      "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PIP"),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Video(
              autoPlay: true,
              showControls: widget.showPlayerControls,
              title: "Something",
              subtitle: "Subtitle",
              isLiveStream: true,
              position: 0,
              url: _url,
              onViewCreated: _onViewCreated,
              desiredState: widget.desiredState,
              loop: false,
            ),
          ),
        ],
      ),
    );
  }

  void _onViewCreated(int viewId) {
    listenForVideoPlayerEvents(viewId);
  }

  @override
  void onTime(int? position) {
    print("$position");
  }
}
