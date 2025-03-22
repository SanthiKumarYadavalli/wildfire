import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wildfire/src/data/models/user_model.dart';
import 'package:wildfire/src/providers/user_provider.dart';

class ProfilePicEdit extends ConsumerWidget {
  const ProfilePicEdit({super.key, required this.user});
  final User user;

  Future<File?> _pickAndCropImage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        )
      ],
    );
    if (cropped == null) return null;
    return File(cropped.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 77,
            backgroundImage: NetworkImage(user.profileImageUrl),
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
                    final File? image = await _pickAndCropImage();
                    if (image == null) return;
                    ref.read(currUserProvider.notifier).updateProfileImage(
                      File(image.path),
                    );
                  },
                )
              ),
          )
        ],
      ),
    );
  }
}
