import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petchrama_theater/domain/provider.dart';

class MovieGrid extends ConsumerStatefulWidget {
  const MovieGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieGridState();
}

class _MovieGridState extends ConsumerState<MovieGrid> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      debugPrint('load more item');
      ref.read(loadMoreItemsProvider);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadMoreItems = ref.watch(loadMoreItemsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: loadMoreItems.when(
            data: (data) => ListView.builder(
              controller: _scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index]),
              ),
            ),
            error: (error, stackTrace) => Center(child: Text('Error: $stackTrace')),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
