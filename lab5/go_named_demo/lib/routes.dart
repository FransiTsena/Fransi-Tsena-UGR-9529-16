import 'package:go_demo/detail.dart';
import 'package:go_demo/home.dart';
import 'package:go_router/go_router.dart';

GoRouter routes = GoRouter(
  routes: [
    GoRoute(path: "/", name: 'home', builder: (_, __) => HomeScreen()),
    GoRoute(
      path: '/detail',
      name: 'detail',
      builder: (_, _) {
        return DetailScreen();
      },
    ),
  ],
);
