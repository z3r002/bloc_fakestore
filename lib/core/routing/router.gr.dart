// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:bloc_pet/features/login/presentation/screens/login_screen.dart'
    as _i3;
import 'package:bloc_pet/features/product/presentation/screens/product_screen.dart'
    as _i1;
import 'package:bloc_pet/features/spalsh/splash_screen.dart' as _i2;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ProductScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductScreen(),
      );
    },
    UISplashScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.UISplashScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ProductScreen]
class ProductScreenRoute extends _i4.PageRouteInfo<void> {
  const ProductScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProductScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UISplashScreen]
class UISplashScreenRoute extends _i4.PageRouteInfo<void> {
  const UISplashScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UISplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UISplashScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i4.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
