// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nowPlayingMoviesHash() => r'6f38c93a042a851a00e7bc7d0b671eb1e3951976';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [nowPlayingMovies].
@ProviderFor(nowPlayingMovies)
const nowPlayingMoviesProvider = NowPlayingMoviesFamily();

/// See also [nowPlayingMovies].
class NowPlayingMoviesFamily extends Family<AsyncValue<NowPlaying?>> {
  /// See also [nowPlayingMovies].
  const NowPlayingMoviesFamily();

  /// See also [nowPlayingMovies].
  NowPlayingMoviesProvider call(
    int page,
  ) {
    return NowPlayingMoviesProvider(
      page,
    );
  }

  @override
  NowPlayingMoviesProvider getProviderOverride(
    covariant NowPlayingMoviesProvider provider,
  ) {
    return call(
      provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nowPlayingMoviesProvider';
}

/// See also [nowPlayingMovies].
class NowPlayingMoviesProvider extends AutoDisposeFutureProvider<NowPlaying?> {
  /// See also [nowPlayingMovies].
  NowPlayingMoviesProvider(
    int page,
  ) : this._internal(
          (ref) => nowPlayingMovies(
            ref as NowPlayingMoviesRef,
            page,
          ),
          from: nowPlayingMoviesProvider,
          name: r'nowPlayingMoviesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nowPlayingMoviesHash,
          dependencies: NowPlayingMoviesFamily._dependencies,
          allTransitiveDependencies:
              NowPlayingMoviesFamily._allTransitiveDependencies,
          page: page,
        );

  NowPlayingMoviesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<NowPlaying?> Function(NowPlayingMoviesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NowPlayingMoviesProvider._internal(
        (ref) => create(ref as NowPlayingMoviesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<NowPlaying?> createElement() {
    return _NowPlayingMoviesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NowPlayingMoviesProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NowPlayingMoviesRef on AutoDisposeFutureProviderRef<NowPlaying?> {
  /// The parameter `page` of this provider.
  int get page;
}

class _NowPlayingMoviesProviderElement
    extends AutoDisposeFutureProviderElement<NowPlaying?>
    with NowPlayingMoviesRef {
  _NowPlayingMoviesProviderElement(super.provider);

  @override
  int get page => (origin as NowPlayingMoviesProvider).page;
}

String _$popularMoviesHash() => r'2add498542deedc2520a0ffde5a47f8fdb86e22c';

/// See also [popularMovies].
@ProviderFor(popularMovies)
final popularMoviesProvider = AutoDisposeFutureProvider<Popular?>.internal(
  popularMovies,
  name: r'popularMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PopularMoviesRef = AutoDisposeFutureProviderRef<Popular?>;
String _$topRateMoviesHash() => r'0a53f65cb4d6c481537c5fba12d2b5711db7b5b5';

/// See also [topRateMovies].
@ProviderFor(topRateMovies)
final topRateMoviesProvider = AutoDisposeFutureProvider<TopRate?>.internal(
  topRateMovies,
  name: r'topRateMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$topRateMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TopRateMoviesRef = AutoDisposeFutureProviderRef<TopRate?>;
String _$upcomingMoviesHash() => r'f09d3fd8c4d272c2275cf681c1e516eabb7cc663';

/// See also [upcomingMovies].
@ProviderFor(upcomingMovies)
final upcomingMoviesProvider = AutoDisposeFutureProvider<Upcoming?>.internal(
  upcomingMovies,
  name: r'upcomingMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpcomingMoviesRef = AutoDisposeFutureProviderRef<Upcoming?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
