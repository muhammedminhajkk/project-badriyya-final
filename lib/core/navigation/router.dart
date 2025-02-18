import 'package:go_router/go_router.dart';
import 'package:project_badriyya/features/public/view/home/pages/home_page.dart';
import 'package:project_badriyya/features/public/view/more/pages/more_page.dart';
import 'package:project_badriyya/features/public/view/profile/pages/profile.dart';
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
