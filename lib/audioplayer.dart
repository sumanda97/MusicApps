import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  //* VARIABEL PLAY & PAUSE BUTTON
  bool playing = false;
  IconData playbtn = Icons.play_arrow;
  // * PLAY BUTTON
  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  //* MUSIC PLAYER
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    // * AUDTIO PLAYER TIME

    // * MUSIC DURATION
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };
    // * MUSIC PLAYING
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };

    //cache.load("ava1.mp3");
  }

  // *COSTUM SLIDER
  Widget slider() {
    return Container(
      width: 300,
      child: Slider.adaptive(
          activeColor: Colors.grey[850],
          inactiveColor: Colors.white,
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  // * SEEK FUNCTION THAT ALLOW POSITION MUSIC
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }
  // * Initialize Music Player

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //* APP BAR
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Playing From Playlist",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              "Ma Favorite",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200),
            )),
          ],
        ),
        actions: [Icon(Icons.more_vert)],
        backgroundColor: Colors.transparent,
      ),
      // * BODY
      body: Container(
        padding: EdgeInsets.only(top: 90),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey[850], Colors.grey[900]])),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * TITLE App
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Music Manda",
                    style: TextStyle(
                        fontSize: 38,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Listen Your Favorite Songs",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white60,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // * LOGO ALBUM

                Center(
                  child: Container(
                      width: 450,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage("assets/ava1.jpg"),
                              fit: BoxFit.fill))),
                ),

                SizedBox(
                  height: 20,
                ),
                // * NAMA PENYANYI
                Center(
                  child: Text(
                    "My Head & My Heart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "Ava Max",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // * BACKGROUND AREA
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),

                  // * BUTTON ACTION
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // * ADDING CONTROLLER
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                              style: TextStyle(fontSize: 18),
                            ),
                            slider(),
                            Text(
                                "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                            iconSize: 45,
                            color: Colors.grey[850],
                            onPressed: () {},
                            icon: Icon(Icons.shuffle),
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            iconSize: 45,
                            color: Colors.grey[850],
                            onPressed: () {},
                            icon: Icon(Icons.skip_previous),
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            iconSize: 45,
                            color: Colors.grey[850],
                            onPressed: () {
                              if (!playing) {
                                cache.play("ava1.mp3");
                                setState(() {
                                  playbtn = Icons.pause;
                                  playing = true;
                                });
                              } else {
                                _player.pause();
                                setState(() {
                                  playbtn = Icons.play_arrow;
                                  playing = false;
                                });
                              }
                            },
                            icon: Icon(
                              playbtn,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            iconSize: 45,
                            color: Colors.grey[850],
                            onPressed: () {},
                            icon: Icon(Icons.skip_next),
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            iconSize: 45,
                            color: Colors.grey[850],
                            onPressed: () {},
                            icon: Icon(Icons.repeat),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
