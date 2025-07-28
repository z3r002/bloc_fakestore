import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/routing/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      page: UISplashScreenRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    AutoRoute(
      page: ProductScreenRoute.page,
      path: '/products',
    ),
  ];
}
