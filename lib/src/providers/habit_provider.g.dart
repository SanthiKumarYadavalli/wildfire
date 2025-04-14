// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getHabitHash() => r'1c38a63d576cf48534435493725df40dd30a579f';

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

/// See also [getHabit].
@ProviderFor(getHabit)
const getHabitProvider = GetHabitFamily();

/// See also [getHabit].
class GetHabitFamily extends Family<AsyncValue<Habit>> {
  /// See also [getHabit].
  const GetHabitFamily();

  /// See also [getHabit].
  GetHabitProvider call(
    String habitId,
  ) {
    return GetHabitProvider(
      habitId,
    );
  }

  @override
  GetHabitProvider getProviderOverride(
    covariant GetHabitProvider provider,
  ) {
    return call(
      provider.habitId,
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
  String? get name => r'getHabitProvider';
}

/// See also [getHabit].
class GetHabitProvider extends AutoDisposeFutureProvider<Habit> {
  /// See also [getHabit].
  GetHabitProvider(
    String habitId,
  ) : this._internal(
          (ref) => getHabit(
            ref as GetHabitRef,
            habitId,
          ),
          from: getHabitProvider,
          name: r'getHabitProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getHabitHash,
          dependencies: GetHabitFamily._dependencies,
          allTransitiveDependencies: GetHabitFamily._allTransitiveDependencies,
          habitId: habitId,
        );

  GetHabitProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    FutureOr<Habit> Function(GetHabitRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetHabitProvider._internal(
        (ref) => create(ref as GetHabitRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Habit> createElement() {
    return _GetHabitProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetHabitProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetHabitRef on AutoDisposeFutureProviderRef<Habit> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _GetHabitProviderElement extends AutoDisposeFutureProviderElement<Habit>
    with GetHabitRef {
  _GetHabitProviderElement(super.provider);

  @override
  String get habitId => (origin as GetHabitProvider).habitId;
}

String _$userHabitsHash() => r'976711be61303201570e3f127d2d1b43946d37c7';

/// See also [UserHabits].
@ProviderFor(UserHabits)
final userHabitsProvider =
    AutoDisposeAsyncNotifierProvider<UserHabits, List<Habit>>.internal(
  UserHabits.new,
  name: r'userHabitsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserHabits = AutoDisposeAsyncNotifier<List<Habit>>;
String _$loadingHabitsHash() => r'026b29245a3bf9b959b499dda19b10690e6d2762';

/// See also [LoadingHabits].
@ProviderFor(LoadingHabits)
final loadingHabitsProvider =
    AutoDisposeNotifierProvider<LoadingHabits, Set<String>>.internal(
  LoadingHabits.new,
  name: r'loadingHabitsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadingHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoadingHabits = AutoDisposeNotifier<Set<String>>;
String _$habitFriendsHash() => r'a187486152902b59bcc3ec64cdf69b804fa485ba';

abstract class _$HabitFriends
    extends BuildlessAutoDisposeAsyncNotifier<List<Map<String, dynamic>>> {
  late final dynamic habitId;

  FutureOr<List<Map<String, dynamic>>> build(
    dynamic habitId,
  );
}

/// See also [HabitFriends].
@ProviderFor(HabitFriends)
const habitFriendsProvider = HabitFriendsFamily();

/// See also [HabitFriends].
class HabitFriendsFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [HabitFriends].
  const HabitFriendsFamily();

  /// See also [HabitFriends].
  HabitFriendsProvider call(
    dynamic habitId,
  ) {
    return HabitFriendsProvider(
      habitId,
    );
  }

  @override
  HabitFriendsProvider getProviderOverride(
    covariant HabitFriendsProvider provider,
  ) {
    return call(
      provider.habitId,
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
  String? get name => r'habitFriendsProvider';
}

/// See also [HabitFriends].
class HabitFriendsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HabitFriends, List<Map<String, dynamic>>> {
  /// See also [HabitFriends].
  HabitFriendsProvider(
    dynamic habitId,
  ) : this._internal(
          () => HabitFriends()..habitId = habitId,
          from: habitFriendsProvider,
          name: r'habitFriendsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$habitFriendsHash,
          dependencies: HabitFriendsFamily._dependencies,
          allTransitiveDependencies:
              HabitFriendsFamily._allTransitiveDependencies,
          habitId: habitId,
        );

  HabitFriendsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final dynamic habitId;

  @override
  FutureOr<List<Map<String, dynamic>>> runNotifierBuild(
    covariant HabitFriends notifier,
  ) {
    return notifier.build(
      habitId,
    );
  }

  @override
  Override overrideWith(HabitFriends Function() create) {
    return ProviderOverride(
      origin: this,
      override: HabitFriendsProvider._internal(
        () => create()..habitId = habitId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HabitFriends,
      List<Map<String, dynamic>>> createElement() {
    return _HabitFriendsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitFriendsProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitFriendsRef
    on AutoDisposeAsyncNotifierProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `habitId` of this provider.
  dynamic get habitId;
}

class _HabitFriendsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HabitFriends,
        List<Map<String, dynamic>>> with HabitFriendsRef {
  _HabitFriendsProviderElement(super.provider);

  @override
  dynamic get habitId => (origin as HabitFriendsProvider).habitId;
}

String _$friendsDisplayValueHash() =>
    r'76b5e51805ac1cf63ee81fcf971082c8ace40c2a';

/// See also [FriendsDisplayValue].
@ProviderFor(FriendsDisplayValue)
final friendsDisplayValueProvider =
    AutoDisposeNotifierProvider<FriendsDisplayValue, String>.internal(
  FriendsDisplayValue.new,
  name: r'friendsDisplayValueProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$friendsDisplayValueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FriendsDisplayValue = AutoDisposeNotifier<String>;
String _$joinFriendHash() => r'ce1348bb108410bff63a1296e592415afef24c7d';

abstract class _$JoinFriend extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String habitId;

  FutureOr<bool> build(
    String habitId,
  );
}

/// See also [JoinFriend].
@ProviderFor(JoinFriend)
const joinFriendProvider = JoinFriendFamily();

/// See also [JoinFriend].
class JoinFriendFamily extends Family<AsyncValue<bool>> {
  /// See also [JoinFriend].
  const JoinFriendFamily();

  /// See also [JoinFriend].
  JoinFriendProvider call(
    String habitId,
  ) {
    return JoinFriendProvider(
      habitId,
    );
  }

  @override
  JoinFriendProvider getProviderOverride(
    covariant JoinFriendProvider provider,
  ) {
    return call(
      provider.habitId,
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
  String? get name => r'joinFriendProvider';
}

/// See also [JoinFriend].
class JoinFriendProvider
    extends AutoDisposeAsyncNotifierProviderImpl<JoinFriend, bool> {
  /// See also [JoinFriend].
  JoinFriendProvider(
    String habitId,
  ) : this._internal(
          () => JoinFriend()..habitId = habitId,
          from: joinFriendProvider,
          name: r'joinFriendProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$joinFriendHash,
          dependencies: JoinFriendFamily._dependencies,
          allTransitiveDependencies:
              JoinFriendFamily._allTransitiveDependencies,
          habitId: habitId,
        );

  JoinFriendProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant JoinFriend notifier,
  ) {
    return notifier.build(
      habitId,
    );
  }

  @override
  Override overrideWith(JoinFriend Function() create) {
    return ProviderOverride(
      origin: this,
      override: JoinFriendProvider._internal(
        () => create()..habitId = habitId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<JoinFriend, bool> createElement() {
    return _JoinFriendProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JoinFriendProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JoinFriendRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _JoinFriendProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<JoinFriend, bool>
    with JoinFriendRef {
  _JoinFriendProviderElement(super.provider);

  @override
  String get habitId => (origin as JoinFriendProvider).habitId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
