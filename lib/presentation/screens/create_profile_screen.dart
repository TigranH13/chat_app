import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  final String email;
  const CreateProfileScreen({
    super.key,
    required this.email,
  });

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple[100],
              child: image == null
                  ? const Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        image!,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: const Text('sds'),
          )
        ],
      ),
    );
  }
}
