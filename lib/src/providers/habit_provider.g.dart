// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$habitFriendsHash() => r'25cbb08a16654a03d68528f5335b96c8493a3994';

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

/// See also [habitFriends].
@ProviderFor(habitFriends)
const habitFriendsProvider = HabitFriendsFamily();

/// See also [habitFriends].
class HabitFriendsFamily extends Family<AsyncValue<List<Friend>>> {
  /// See also [habitFriends].
  const HabitFriendsFamily();

  /// See also [habitFriends].
  HabitFriendsProvider call(
    String habitId,
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

/// See also [habitFriends].
class HabitFriendsProvider extends AutoDisposeFutureProvider<List<Friend>> {
  /// See also [habitFriends].
  HabitFriendsProvider(
    String habitId,
  ) : this._internal(
          (ref) => habitFriends(
            ref as HabitFriendsRef,
            habitId,
          ),
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

  final String habitId;

  @override
  Override overrideWith(
    FutureOr<List<Friend>> Function(HabitFriendsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitFriendsProvider._internal(
        (ref) => create(ref as HabitFriendsRef),
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
  AutoDisposeFutureProviderElement<List<Friend>> createElement() {
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
mixin HabitFriendsRef on AutoDisposeFutureProviderRef<List<Friend>> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitFriendsProviderElement
    extends AutoDisposeFutureProviderElement<List<Friend>>
    with HabitFriendsRef {
  _HabitFriendsProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitFriendsProvider).habitId;
}

String _$userHabitsHash() => r'0c84997c586aa3426950ac46c87df1f615662571';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
