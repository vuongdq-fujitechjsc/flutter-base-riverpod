import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar(this.navigationShell, {super.key});

  // The navigation shell and container for the branch Navigators
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(tabIndex){
    navigationShell.goBranch(
      tabIndex,
      initialLocation: tabIndex == navigationShell.currentIndex
    );
  }
}