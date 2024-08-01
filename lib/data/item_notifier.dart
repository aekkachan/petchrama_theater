import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petchrama_theater/data/datasources/remote/movies_rest_api.dart';
import 'package:petchrama_theater/data/model/now_playing.dart';
import 'package:petchrama_theater/utils/resource/dio_configuration.dart';

class ItemNotifier extends StateNotifier<PagingState<int, NowPlaying>> {
  // ItemNotifier() : super(PagingState());

  final PagingController<int, NowPlaying> pagingController = PagingController(firstPageKey: 0);

  ItemNotifier() : super(PagingState()) {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  static const int _pageSize = 20;

  Future<void> fetchPage(int pageKey) async {
    // final response = await http.get(Uri.parse('$apiUrl?page=$pageKey&size=$pageSize'));

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body) as List;
    //   return data.map((item) => Item.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load items');
    // }

    NowPlaying data = await MoviesRestApi(DioConfiguration.getInstance()).getNowPlayingMovies('en-US', pageKey);

    //   try {
    //     // Simulate fetching data from an API or database
    //     await Future.delayed(const Duration(seconds: 2));
    //     final newItems = List.generate(
    //       _pageSize,
    //       (index) => Item(id: pageKey + index, name: 'Item ${pageKey + index}'),
    //     );
    //     final isLastPage = newItems.length < _pageSize;
    //     if (isLastPage) {
    //       state = PagingState(
    //         nextPageKey: null,
    //         itemList: [...state.itemList ?? [], ...newItems],
    //       );
    //     } else {
    //       final nextPageKey = pageKey + newItems.length;
    //       state = PagingState(
    //         nextPageKey: nextPageKey,
    //         itemList: [...state.itemList ?? [], ...newItems],
    //       );
    //     }
    //   } catch (error) {
    //     state = PagingState(
    //       error: error,
    //       itemList: state.itemList,
    //     );
    //   }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

final itemNotifierProvider = StateNotifierProvider<ItemNotifier, PagingState<int, NowPlaying>>(
  (ref) => ItemNotifier(),
);
