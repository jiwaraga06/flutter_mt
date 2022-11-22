import 'package:flutter/material.dart';
import 'package:flutter_mt/source/pages/Home/Perawatan/perawatan.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/perbaikan.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => MyTabBarState();
}

class MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        bottom: TabBar(controller: controller, indicatorColor: Colors.white, tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text("Perbaikan"),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.security),
                SizedBox(width: 8),
                Text("Perawatan"),
              ],
            ),
          ),
        ]),
      ),
      body: TabBarView(
        controller: controller,
        children: [Perbaikan(), Perawatan()],
      ),
    );
  }
}
