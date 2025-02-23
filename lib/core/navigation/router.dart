import 'package:go_router/go_router.dart';
import 'package:project_badriyya/features/public/home/view/pages/home_page.dart';
import 'package:project_badriyya/features/public/more/view/pages/more_page.dart';
import 'package:project_badriyya/features/public/profile/view/pages/profile.dart';
import 'package:project_badriyya/main.dart';

final router = GoRouter(
    initialLocation: HomePage.routePath,
    navigatorKey: MyApp.navigatorKey,
    routes: [
      GoRoute(
        path: HomePage.routePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: MorePage.routePath,
        builder: (context, state) => const MorePage(),
      ),
      GoRoute(
        path: Profile.routePath,
        builder: (context, state) => const Profile(),
      ),
    ]);
