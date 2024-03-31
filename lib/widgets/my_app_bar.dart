import 'package:flutter/material.dart';
import 'package:flutter_blogger/screnns/profile.dart';
import 'package:flutter_blogger/widgets/display_image.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('Home'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DisplayImage(
            onTap: () {
              // navigate to profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
