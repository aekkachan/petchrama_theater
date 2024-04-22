import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Now Playing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25, letterSpacing: 4),
        ),
        centerTitle: false,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left_rounded)),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
