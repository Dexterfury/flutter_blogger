import 'package:flutter/material.dart';
import 'package:flutter_blogger/providers/user_provider.dart';
import 'package:flutter_blogger/widgets/display_image.dart';
import 'package:flutter_blogger/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().user!.name;
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const DisplayImage(radius: 50.0),
              const SizedBox(height: 20.0),
              Text(userName)
            ]),
      ),
    );
  }
}
