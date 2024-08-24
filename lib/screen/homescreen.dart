import 'package:custom_persistent_bottom_navbar/screen/nextscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    print("Home ke init");
    super.initState();
  }

  @override
  void dispose() {
    print("Home ke dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: false).push(
                      CupertinoPageRoute(
                          builder: (context) => const Nextscreen()));
                },
                child: const Text('Home Page'))));
  }
}
