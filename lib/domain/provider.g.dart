// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nowPlayingMoviesHash() => r'7b9190ba86a809a7be10c2ec52ba72fe1fa321df';

/// See also [nowPlayingMovies].
@ProviderFor(nowPlayingMovies)
final nowPlayingMoviesProvider =
    AutoDisposeFutureProvider<NowPlaying?>.internal(
  nowPlayingMovies,
  name: r'nowPlayingMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nowPlayingMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NowPlayingMoviesRef = AutoDisposeFutureProviderRef<NowPlaying?>;
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
String _$creditMoviesHash() => r'49edba061d9779f2c203113c26bed9d64130c9a2';

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

/// See also [creditMovies].
@ProviderFor(creditMovies)
const creditMoviesProvider = CreditMoviesFamily();

/// See also [creditMovies].
class CreditMoviesFamily extends Family<AsyncValue<Credits?>> {
  /// See also [creditMovies].
  const CreditMoviesFamily();

  /// See also [creditMovies].
  CreditMoviesProvider call(
    String id,
  ) {
    return CreditMoviesProvider(
      id,
    );
  }

  @override
  CreditMoviesProvider getProviderOverride(
    covariant CreditMoviesProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'creditMoviesProvider';
}

/// See also [creditMovies].
class CreditMoviesProvider extends AutoDisposeFutureProvider<Credits?> {
  /// See also [creditMovies].
  CreditMoviesProvider(
    String id,
  ) : this._internal(
          (ref) => creditMovies(
            ref as CreditMoviesRef,
            id,
          ),
          from: creditMoviesProvider,
          name: r'creditMoviesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$creditMoviesHash,
          dependencies: CreditMoviesFamily._dependencies,
          allTransitiveDependencies:
              CreditMoviesFamily._allTransitiveDependencies,
          id: id,
        );

  CreditMoviesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Credits?> Function(CreditMoviesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreditMoviesProvider._internal(
        (ref) => create(ref as CreditMoviesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Credits?> createElement() {
    return _CreditMoviesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreditMoviesProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreditMoviesRef on AutoDisposeFutureProviderRef<Credits?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CreditMoviesProviderElement
    extends AutoDisposeFutureProviderElement<Credits?> with CreditMoviesRef {
  _CreditMoviesProviderElement(super.provider);

  @override
  String get id => (origin as CreditMoviesProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
