import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;
  bool _isPro = false; // TODO: load from shared_preferences / backend

  void _onProChanged(bool value) {
    setState(() => _isPro = value);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(isPro: _isPro),
      // ── Add more tab screens here ──────────────────────────────────
      _PlaceholderScreen(
        icon: Icons.explore_outlined,
        label: 'Explore',
        isPro: _isPro,
      ),
      _PlaceholderScreen(
        icon: Icons.bookmark_outline,
        label: 'Saved',
        isPro: _isPro,
      ),
      ProfileScreen(isPro: _isPro, onProChanged: _onProChanged),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: Color(0xFFE5E7EB), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark_rounded),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

/// Generic placeholder screen — swap out with real screens as you build
class _PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPro;

  const _PlaceholderScreen({
    required this.icon,
    required this.label,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, color: AppTheme.primary, size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$label Screen',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Build your content here',
                    style: TextStyle(color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
          ),
          // ignore: avoid_redundant_argument_values
          if (!isPro)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Center(
                        child: Text('Ad placeholder',
                            style: TextStyle(color: AppTheme.textMuted))),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
