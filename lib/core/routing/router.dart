import 'package:auto_route/auto_route.dart';
import 'package:bloc_pet/core/routing/router.gr.dart';
import 'package:bloc_pet/core/services/auth_service.dart';
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
  final AuthService _authService = AuthService();
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await _authService.isAuthenticated();
    
    if (isAuthenticated) {
      // If authenticated, allow the navigation to proceed
      resolver.next(true);
    } else {
      // If not authenticated, redirect to login
      // and store the original route to navigate back after login
      final originalRoute = resolver.route;
      
      router.pushAndPopUntil(
        const LoginScreenRoute(),
        predicate: (route) => false, // Clear all routes
        onFailure: (failure) {
          // Handle navigation failure
          print('Navigation to login failed: $failure');
        },
      );
    }
  }
}
