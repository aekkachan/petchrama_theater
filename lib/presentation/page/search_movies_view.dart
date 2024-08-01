import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petchrama_theater/domain/provider.dart';
import 'package:petchrama_theater/utils/constants/constant.dart';
import 'package:petchrama_theater/utils/extension/space_rxtension.dart';

class SearchMoviesView extends ConsumerStatefulWidget {
  const SearchMoviesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMoviesViewState();
}

class _SearchMoviesViewState extends ConsumerState<SearchMoviesView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _suggestChip = ref.watch(suggestChipProvider);

    double screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        physics: _suggestChip ? NeverScrollableScrollPhysics() : ScrollPhysics(),
        scrollBehavior: MaterialScrollBehavior(),
        shrinkWrap: true,
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            delegate: SliverHeaderDelegateComponent(expandedHeight: screenHight * 0.1),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Item #${index + 1}'),
                  subtitle: Text('Subtitle of item #${index + 1}'),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    ));
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight || oldDelegate.child != child;
  }
}

class SliverHeaderDelegateComponent extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const SliverHeaderDelegateComponent({required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _searchBoxBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeLine, width: 1.5),
      borderRadius: BorderRadius.circular(25.0),
    );

    Widget _suggestionChip(String title) {
      return GestureDetector(
        onTap: () {
          print(title);
        },
        child: Chip(
          label: Text(
            title,
            style: TextStyle(color: AppColors.themeLine),
          ),
          backgroundColor: AppColors.themeBg,
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
      );
    }

    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
        height: expandedHeight + expandedHeight / 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PositionedDirectional(
              start: 0.0,
              end: 0.0,
              // top: appBarSize > 0 ? appBarSize : 0,
              top: 0,
              // bottom: -150,
              bottom: 0,
              child: Opacity(
                  opacity: percent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 30 * percent, vertical: 20 * percent),
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            labelText: 'Search Movies',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintFadeDuration: Durations.extralong1,
                            prefixIcon: Icon(CupertinoIcons.search),
                            suffixIcon: Icon(Icons.close),
                            enabledBorder: _searchBoxBorder,
                            focusedBorder: _searchBoxBorder,
                            errorBorder: _searchBoxBorder,
                            focusedErrorBorder: _searchBoxBorder,
                          ),
                        ),
                      ),
                      Flexible(
                          child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _suggestionChip('Action'),
                          10.kW,
                          _suggestionChip('Drama'),
                          10.kW,
                          _suggestionChip('Comedy'),
                          10.kW,
                          _suggestionChip('Horror'),
                          10.kW,
                          _suggestionChip('Sci-Fi'),
                        ],
                      ))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
