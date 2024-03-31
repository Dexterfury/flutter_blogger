import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blogger/providers/user_provider.dart';
import 'package:flutter_blogger/utilities/utilities.dart';
import 'package:flutter_blogger/widgets/display_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({super.key});

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  // controller for user name
  TextEditingController controller = TextEditingController();

  // final image file
  File? finalImageFile;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // pick image from gallery or camera
  void selectImage({required bool fromCamera}) async {
    final pickedImage = await pickImage(fromCamera: fromCamera);
    if (pickedImage != null) {
      // crop image
      await cropImage(pickedImage.path);

      popContext();
    }
  }

  popContext() {
    Navigator.pop(context);
  }

  Future<void> cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );

    if (croppedFile != null) {
      finalImageFile = File(croppedFile.path);
      setState(() {});
      updateImage();
    }
  }

  void updateImage() {
    final userProvider = context.read<UserProvider>();
    userProvider.updateImage(finalImageFile!);
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                selectImage(fromCamera: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                selectImage(fromCamera: false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final userName = context.watch<UserProvider>().userName;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DisplayImage(
                file: finalImageFile,
                radius: 50.0,
                onTap: () {
                  showBottomSheet();
                },
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        userProvider.user!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          // show edit dialog
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Edit User Name'),
                                    content: TextField(
                                      controller: controller,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // close dialog
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // save user name
                                          userProvider
                                              .updateName(controller.text);

                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Text(
                    userProvider.user!.email,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
