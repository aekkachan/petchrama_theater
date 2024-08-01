import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petchrama_theater/data/model/now_playing.dart';

class AllMoviesView extends ConsumerStatefulWidget {
  const AllMoviesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllMoviesViewState();
}

class _AllMoviesViewState extends ConsumerState<AllMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left_rounded),
          ),
          title: Text('All Movies'),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.amber,
          ),
        ));
  }
}
