import 'package:anime_nation/app/widget/custom_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../pages/favorites/favorites_page.dart';
import '../pages/home/list/home_list_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/explore/explore_page.dart';

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardtState();
}

class _DashboardtState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> screens = [
    const HomeListPage(),
    const ExplorePage(),
    const FavoritesPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: screens.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: GNav(
                backgroundColor: const Color.fromARGB(255, 6, 4, 4),
                color: Colors.grey,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                onTabChange: (value) => {_tabController.animateTo(value)},
                gap: 12,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                    fontFamily: "SfProTextMedium", color: Colors.white),
                tabs: const [
                  GButton(icon: CustomIcons.home, text: "Home"),
                  GButton(icon: Icons.explore, text: "Explore"),
                  GButton(icon: CustomIcons.list, text: "My List"),
                  GButton(icon: Icons.person, text: "Profile")
                ]),
          ),
        ));
  }
}
