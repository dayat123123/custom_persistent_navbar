import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nextscreen extends StatefulWidget {
  const Nextscreen({super.key});

  @override
  State<Nextscreen> createState() => _NextscreenState();
}

class _NextscreenState extends State<Nextscreen> {
  @override
  void initState() {
    print("Init");
    super.initState();
  }

  @override
  void dispose() {
    print("Nextscreen Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nextscreen')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => Nextscreen()),
            );
          },
          child: const Text('Nextscreen Page'),
        ),
      ),
    );
  }
}
