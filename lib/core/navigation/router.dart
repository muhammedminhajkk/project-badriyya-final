import 'package:badriyya/features/public/dashboard/login/pages/confirm.dart';
import 'package:badriyya/features/public/dashboard/login/pages/login.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_class.dart';
import 'package:badriyya/features/public/dashboard/teachers/pages/teacher_periods.dart';
import 'package:badriyya/features/public/home/home_page.dart';
import 'package:badriyya/features/public/more/view/pages/more_page.dart';
import 'package:badriyya/main.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(
  initialLocation: HomePage.routePath,
  navigatorKey: MyApp.navigatorKey,
  routes: [
    GoRoute(
      path: HomePage.routePath,
      pageBuilder:
          (context, state) => const NoTransitionPage(child: HomePage()),
    ),
    GoRoute(
      path: MorePage.routePath,
      pageBuilder:
          (context, state) => const NoTransitionPage(child: MorePage()),
    ),
    GoRoute(
      path: Profile.routePath,
      redirect: (context, state) async {
        final loggedIn = await isLoggedIn();
        if (loggedIn) {
          return ConfirmPage.routePath;
        }
        return null;
      },
      pageBuilder: (context, state) => const NoTransitionPage(child: Profile()),
    ),
    GoRoute(
      path: TeacherClassPage.routePath,
      pageBuilder:
          (context, state) => const NoTransitionPage(child: TeacherClassPage()),
    ),
    GoRoute(
      path: TeacherPeriodsPage.routePath,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isMain = extra?['isMain'] as bool? ?? true;
        return NoTransitionPage(child: TeacherPeriodsPage(isMain: isMain));
      },
    ),
    GoRoute(
      path: ConfirmPage.routePath,
      pageBuilder:
          (context, state) => const NoTransitionPage(child: ConfirmPage()),
    ),
  ],
);

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  return token != null && token.isNotEmpty;
}
