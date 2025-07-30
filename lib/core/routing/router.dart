import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/routing/router.gr.dart';
import 'package:bloc_pet/features/login/presentation/screens/login_screen.dart';

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
      page: LoginScreenRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: ProductScreenRoute.page,
      path: '/products',
      guards: [AuthGuard()],
    ),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Here you can add your authentication logic
    // For now, we'll redirect to login if not authenticated
    router.pushNamed('/login');
  }
}
