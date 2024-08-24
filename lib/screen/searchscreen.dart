import 'package:custom_persistent_bottom_navbar/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    print("Init SearchScreen");
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose SearchScreen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => const PageViewTest()),
              (route) => false,
            );
          },
          child: const Text('Search Page'),
        ),
      ),
    );
  }
}
