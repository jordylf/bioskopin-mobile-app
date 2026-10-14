// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class MainNavigationPage extends HookWidget {
  final Widget child;

  const MainNavigationPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);
    final lastPressed = useRef<DateTime?>(null);

    final List<String> routeList = [
      '/home',
      '/booking',
      '/profile',
    ];

    void onItemTapped({required int index}) {
      currentIndex.value = index;

      context.go(routeList[index]);
    }

    useEffect(
      () {
        final currentLocation =
            GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

        currentIndex.value =
            routeList.indexWhere((route) => currentLocation.startsWith(route));
        return null;
      },
      [GoRouter.of(context).routerDelegate.currentConfiguration.fullPath],
    );

    Future<bool> onWillPop() async {
      final now = DateTime.now();

      if (currentIndex.value != 0) {
        onItemTapped(index: 0);

        return false;
      }

      if (lastPressed.value == null ||
          now.difference(lastPressed.value!) > const Duration(seconds: 2)) {
        lastPressed.value = now;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Tekan kembali sekali lagi untuk keluar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10.0),
            duration: const Duration(seconds: 3),
          ),
        );
        return false;
      } else {
        return true;
      }
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: child,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: const IconThemeData(size: 30.0, opacity: 1.0),
              unselectedIconTheme:
                  const IconThemeData(size: 28.0, opacity: 0.5),
              selectedLabelStyle: const TextStyle(fontSize: 14.0),
              unselectedLabelStyle: const TextStyle(fontSize: 14.0),
              elevation: 0,
              backgroundColor: Color(0xFF277FBF),
              selectedFontSize: 16.0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade300,
              items: const [
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_outlined, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  activeIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  activeIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  label: 'Pemesanan',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  activeIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 24.0),
                      SizedBox(height: 4.0),
                    ],
                  ),
                  label: 'Profil',
                ),
              ],
              currentIndex: currentIndex.value,
              onTap: (index) => onItemTapped(index: index),
            ),
          ),
        ),
      ),
    );
  }
}
