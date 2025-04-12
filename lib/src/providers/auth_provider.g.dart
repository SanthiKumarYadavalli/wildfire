// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyTokenHash() => r'096073380ad91b583fe9bd79314050eb5c974960';

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

/// See also [verifyToken].
@ProviderFor(verifyToken)
const verifyTokenProvider = VerifyTokenFamily();

/// See also [verifyToken].
class VerifyTokenFamily extends Family<AsyncValue<bool>> {
  /// See also [verifyToken].
  const VerifyTokenFamily();

  /// See also [verifyToken].
  VerifyTokenProvider call(
    String token,
  ) {
    return VerifyTokenProvider(
      token,
    );
  }

  @override
  VerifyTokenProvider getProviderOverride(
    covariant VerifyTokenProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'verifyTokenProvider';
}

/// See also [verifyToken].
class VerifyTokenProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [verifyToken].
  VerifyTokenProvider(
    String token,
  ) : this._internal(
          (ref) => verifyToken(
            ref as VerifyTokenRef,
            token,
          ),
          from: verifyTokenProvider,
          name: r'verifyTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyTokenHash,
          dependencies: VerifyTokenFamily._dependencies,
          allTransitiveDependencies:
              VerifyTokenFamily._allTransitiveDependencies,
          token: token,
        );

  VerifyTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    FutureOr<bool> Function(VerifyTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerifyTokenProvider._internal(
        (ref) => create(ref as VerifyTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _VerifyTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyTokenProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerifyTokenRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `token` of this provider.
  String get token;
}

class _VerifyTokenProviderElement extends AutoDisposeFutureProviderElement<bool>
    with VerifyTokenRef {
  _VerifyTokenProviderElement(super.provider);

  @override
  String get token => (origin as VerifyTokenProvider).token;
}

String _$loginHash() => r'cd729034722c498c0b195c93db4e62a32f9bed7f';

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
String _$forgotPasswordHash() => r'32cae7a8e8c6340f748735da7d0a2996e784de1c';

/// See also [ForgotPassword].
@ProviderFor(ForgotPassword)
final forgotPasswordProvider =
    AutoDisposeAsyncNotifierProvider<ForgotPassword, bool>.internal(
  ForgotPassword.new,
  name: r'forgotPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$forgotPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ForgotPassword = AutoDisposeAsyncNotifier<bool>;
String _$resetPasswordHash() => r'e76f4396d48a6540d08259e14b492294562d9bfb';

/// See also [ResetPassword].
@ProviderFor(ResetPassword)
final resetPasswordProvider =
    AutoDisposeAsyncNotifierProvider<ResetPassword, bool>.internal(
  ResetPassword.new,
  name: r'resetPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResetPassword = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
