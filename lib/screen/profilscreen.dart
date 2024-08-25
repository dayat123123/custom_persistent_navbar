import 'package:custom_persistent_bottom_navbar/screen/nextscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    print("Init profile");
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose profile");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: false).push(
              CupertinoPageRoute(builder: (context) => const Nextscreen()),
            );
          },
          child: const Text('Profile Page'),
        ),
      ),
    );
  }
}
