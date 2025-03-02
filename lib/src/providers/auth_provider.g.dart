// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginHash() => r'1cb8267fa718ac63b0bbd22bb9cc58bc49c88a55';

/// See also [Login].
@ProviderFor(Login)
final loginProvider = AutoDisposeAsyncNotifierProvider<Login, String>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeAsyncNotifier<String>;
String _$signupHash() => r'2c18cfcc724e0b6a4d5b8017d730c6ae790abac2';

/// See also [Signup].
@ProviderFor(Signup)
final signupProvider = AutoDisposeAsyncNotifierProvider<Signup, void>.internal(
  Signup.new,
  name: r'signupProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Signup = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
