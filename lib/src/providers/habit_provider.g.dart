// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHabitsHash() => r'66203f7b11946ac8f47b2be803fbc031ebec86ab';

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
