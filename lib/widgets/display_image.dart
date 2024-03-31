import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blogger/providers/user_provider.dart';
import 'package:flutter_blogger/utilities/assets_manager.dart';
import 'package:provider/provider.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({
    super.key,
    this.file,
    this.radius = 30.0,
    this.onTap,
  });

  final File? file;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user!;
    getImmageToShow() {
      if (file != null) {
        return FileImage(File(file!.path)) as ImageProvider<Object>;
      } else if (user.imageUrl.isNotEmpty) {
        return FileImage(File(user.imageUrl)) as ImageProvider<Object>;
      } else {
        return const AssetImage(AssetsManager.userIcon);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: getImmageToShow(),
        radius: radius,
      ),
    );
  }
}
