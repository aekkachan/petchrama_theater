import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petchrama_theater/data/model/popular.dart';
import 'package:petchrama_theater/presentation/page/movie_detail.dart';
import 'package:petchrama_theater/utils/constants/apis.dart';
import 'dart:math' as math;

import 'package:petchrama_theater/utils/constants/genres.dart';

class CustomCarouselPageView extends StatefulWidget {
  const CustomCarouselPageView({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  factory CustomCarouselPageView.images(BuildContext context, List<Result> result) {
    return CustomCarouselPageView(
      children: result.map((data) => _buildImageCard(context, data)).toList(),
    );
  }

  static Widget _buildImageCard(BuildContext context, Result data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetail(
                    imgTag: '${data.title}movie_poster',
                    imgPath: '${Apis.baseTMDBimg}${data.posterPath}',
                    backdropPath: '${Apis.baseTMDBimg}${data.backdropPath}',
                    title: data.title,
                    content: data.overview,
                    voteAgerage: data.voteAverage,
                    voteCount: data.voteCount,
                    releaseDate: data.releaseDate,
                    orginalLanguage: data.originalLanguage,
                    isAdult: data.adult,
                    genreIds: data.genreIds,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              clipBehavior: Clip.antiAlias,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: '${Apis.baseTMDBimg}${data.posterPath}',
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
                placeholderFadeInDuration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                data.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              getGenre(data.genreIds!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String getGenre(List<int> genreIds) {
    String genre = '';

    for (int i = 0; i < genreIds.length; i++) {
      genre += Genres.ids[genreIds[i].toString()]!;
      if (i < genreIds.length - 1) genre += ' / ';
    }
    return genre;
  }

  @override
  State createState() => _CustomCarouselPageViewState();
}

double viewportFraction = 0.75;

class _CustomCarouselPageViewState extends State<CustomCarouselPageView> {
  final pageController = PageController(viewportFraction: viewportFraction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final maxWidth = constraint.maxWidth;
        return PageView.builder(
          allowImplicitScrolling: true,
          controller: pageController,
          itemCount: widget.children.length,
          itemBuilder: (_, index) {
            final child = widget.children[index];
            return AnimatedBuilder(
              animation: pageController,
              builder: (context, _) {
                final ratioX = pageController.offset / maxWidth / viewportFraction - index;

                return Transform.rotate(
                  angle: math.pi * -0.05 * ratioX,
                  child: Transform.translate(
                    offset: Offset(ratioX * 20, ratioX.abs() * 30),
                    child: Transform.scale(
                      scale: 0.85,
                      child: child,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
