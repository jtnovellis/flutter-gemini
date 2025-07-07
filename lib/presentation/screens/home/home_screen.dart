import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Basic prompt to Gemini'),
            subtitle: const Text('Using flash model'),
            leading: const CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(Icons.person_2_outlined),
            ),
            onTap: () => context.push('/basic-prompt'),
          ),
        ],
      ),
    );
  }
}
