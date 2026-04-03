import 'package:go_demo/detail.dart';
import 'package:go_demo/home.dart';
import 'package:go_router/go_router.dart';

GoRouter routes = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final filter = state.uri.queryParameters['filter'] ?? 'all';
        return DetailScreen(id: id, filter: filter);
      },
    ),
  ],
);
