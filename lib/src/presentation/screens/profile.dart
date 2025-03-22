import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final user = ref.watch(currUserProvider);
    final ImagePicker picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user.when(
        data: (user) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 77,
                      backgroundImage: NetworkImage(user!.profileImageUrl),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onPrimary),
                          onPressed: () async {
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            CroppedFile? cropped = await ImageCropper().cropImage(
                              sourcePath: image.path,
                              uiSettings: [
                                AndroidUiSettings(
                                  lockAspectRatio: true,
                                  initAspectRatio: CropAspectRatioPreset.square,
                                  hideBottomControls: true,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square
                                  ],
                                )
                              ],
                            );
                            if (cropped == null) return;
                            ref.read(currUserProvider.notifier).updateProfileImage(
                              File(cropped.path),
                            );
                          },
                        )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: const Text('Name'),
                subtitle: Text(user.name),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
                subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.edit),
                onTap: () {
                  nameController.text = user.name;
                  nameController.selection = TextSelection(baseOffset: 0, extentOffset: user.name.length);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                                controller: nameController,
                                autofocus: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () {
                                      ref.read(currUserProvider.notifier).updateName(nameController.text);
                                      context.pop();
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
              ListTile(
                title: const Text('Username'),
                subtitle: Text(user.username),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
                subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                leading: Icon(Icons.tag),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 15),
                subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
                leading: Icon(Icons.email),
              )
            ],
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, _) => Text('Error: $error'),
      )
    );
  }
}